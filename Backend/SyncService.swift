//
//  SyncManager.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 07/02/2024.
//

import Foundation
import CoreData
import Combine

// MARK: - Remote Models
struct RemoteCard: Codable {
    let id: String
    let navn: String
    let kulhydrat: Double
    let maaleenhed: String
    let maengde: Double
    let aktivMaengde: Double
    let imageData: String? // Changed to String for base64
    let kategori: String?
    let isFavorite: Bool
    let userId: Int
    let deckId: String
}

struct RemoteCategory: Codable {
    let id: String
    let navn: String
    let oprettelsesdato: Date
    let userId: Int
}

struct RemoteMeal: Codable {
    let id: String
    let name: String
    let totalCarbs: Double
    let createdDate: Date
    let userId: Int
    let mealItems: [RemoteMealItem]
}

struct RemoteMealItem: Codable {
    let id: String
    let name: String
    let amount: Double
    let calculatedCarbs: Double
}

// MARK: - SyncManager
class SyncManager {
    static let shared = SyncManager()
    private let baseURL = "http://localhost:3000/api"
    private var cancellables = Set<AnyCancellable>()
    private let context = PersistenceController.shared.container.viewContext
    
    private var authToken: String {
        UserDefaults.standard.string(forKey: "authToken") ?? ""
    }
    
    private var userId: Int? {
        UserDefaults.standard.object(forKey: "userId") as? Int
    }
    
    init() {
        setupNetworkMonitor()
    }
    
    // MARK: - Network Monitoring
    private func setupNetworkMonitor() {
        NetworkMonitor.shared.$isConnected
            .sink { [weak self] isConnected in
                if isConnected {
                    self?.syncAll()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Synchronization Methods
    func syncAll() {
        guard let _ = userId else { return }
        syncCategories()
        syncUserCards()
        syncMeals()
        syncFavorites()  // Add this line
    }
    
    // MARK: - Categories Sync
    func syncCategories() {
        guard let url = URL(string: "\(baseURL)/categories") else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [RemoteCategory].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Failed to sync categories: \(error)")
                    }
                },
                receiveValue: { [weak self] categories in
                    self?.mergeCategoriesFromBackend(categories)
                }
            )
            .store(in: &cancellables)
    }
    
    // MARK: - BrugerdefineredeKort Sync
    func syncUserCards() {
        fetchRemoteCards()
    }
    
    private func fetchRemoteCards() {
        guard let url = URL(string: "\(baseURL)/cards") else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [RemoteCard].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Failed to sync cards with backend: \(error)")
                    }
                },
                receiveValue: { [weak self] remoteCards in
                    self?.mergeCardsFromBackend(remoteCards)
                }
            )
            .store(in: &cancellables)
    }
    
    func syncCard(_ card: BrugerdefineredeKort) {
        guard let url = URL(string: "\(baseURL)/cards"),
              let userId = self.userId else { return }
        
        let cardData: [String: Any] = [
            "id": card.id?.uuidString ?? UUID().uuidString,
            "navn": card.navn ?? "",
            "kulhydrat": card.kulhydrat,
            "maaleenhed": card.maaleenhed ?? "",
            "maengde": card.maengde,
            "aktivMaengde": card.aktivMaengde,
            "imageData": card.imageData?.base64EncodedString() ?? "",
            "kategori": card.kategori ?? "",
            "isFavorite": card.isFavorite,
            "userId": userId,
            "deckId": card.deckId?.uuidString ?? ""
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: cardData)
        } catch {
            print("Error encoding card data: \(error)")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Failed to sync card to backend: \(error)")
                    }
                },
                receiveValue: { _ in
                    print("Successfully synced card to backend")
                }
            )
            .store(in: &cancellables)
    }
    
    func deleteCard(_ card: BrugerdefineredeKort) {
        guard let cardId = card.id?.uuidString,
              let url = URL(string: "\(baseURL)/cards/\(cardId)") else {
            print("Invalid card ID")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Failed to delete card from backend: \(error)")
                    }
                },
                receiveValue: { _ in
                    print("Successfully deleted card from backend")
                }
            )
            .store(in: &cancellables)
    }
    
    // MARK: - Meals Sync
    func syncMeals() {
        fetchRemoteMeals()
    }
    
    private func fetchRemoteMeals() {
        guard let url = URL(string: "\(baseURL)/meals") else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [RemoteMeal].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Failed to sync meals with backend: \(error)")
                    }
                },
                receiveValue: { [weak self] remoteMeals in
                    self?.mergeMealsFromBackend(remoteMeals)
                }
            )
            .store(in: &cancellables)
    }
    
    func syncMeal(_ meal: SavedMeal) {
        guard let url = URL(string: "\(baseURL)/meals"),
              let userId = self.userId else { return }
        
        let mealData: [String: Any] = [
            "id": meal.id.uuidString,
            "name": meal.name,
            "totalCarbs": meal.totalCarbs,
            "userId": userId,
            "items": meal.mealItemsArray.map { [
                "name": $0.name,
                "amount": $0.amount,
                "calculatedCarbs": $0.calculatedCarbs
            ]}
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: mealData)
        } catch {
            print("Error encoding meal data: \(error)")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Failed to sync meal to backend: \(error)")
                    }
                },
                receiveValue: { _ in
                    print("Successfully synced meal to backend")
                }
            )
            .store(in: &cancellables)
    }
    
    
    func syncFavorites() {
        guard let userId = self.userId else { return }
        
        // Fetch all favorite cards
        let request: NSFetchRequest<BrugerdefineredeKort> = BrugerdefineredeKort.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == YES AND userId == %d", userId)
        
        do {
            let favoriteCards = try context.fetch(request)
            for card in favoriteCards {
                syncCard(card)  // This will update the backend with favorite status
            }
        } catch {
            print("Error fetching favorite cards: \(error)")
        }
    }

   
    
    
    
    // MARK: - Merge Logic
    private func mergeCategoriesFromBackend(_ remoteCategories: [RemoteCategory]) {
        guard let userId = self.userId else { return }
        
        let userCategories = remoteCategories.filter { $0.userId == userId }
        
        for remoteCategory in userCategories {
            let request: NSFetchRequest<Categories> = Categories.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", remoteCategory.id)
            
            do {
                let existingCategories = try context.fetch(request)
                let category = existingCategories.first ?? Categories(context: context)
                
                category.id = UUID(uuidString: remoteCategory.id)
                category.navn = remoteCategory.navn
                category.oprettelsesdato = remoteCategory.oprettelsesdato
                category.userId = Int64(userId)
            } catch {
                print("Error merging category: \(error)")
            }
        }
        
        saveContext()
    }
    
    private func mergeCardsFromBackend(_ remoteCards: [RemoteCard]) {
        guard let userId = self.userId else { return }
        
        let userCards = remoteCards.filter { $0.userId == userId }
        
        for remoteCard in userCards {
            let request: NSFetchRequest<BrugerdefineredeKort> = BrugerdefineredeKort.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", remoteCard.id)
            
            do {
                let existingCards = try context.fetch(request)
                let card = existingCards.first ?? BrugerdefineredeKort(context: context)
                
                card.id = UUID(uuidString: remoteCard.id)
                card.navn = remoteCard.navn
                card.kulhydrat = remoteCard.kulhydrat
                card.maaleenhed = remoteCard.maaleenhed
                card.maengde = remoteCard.maengde
                card.aktivMaengde = remoteCard.aktivMaengde
                if let imageDataString = remoteCard.imageData {
                    card.imageData = Data(base64Encoded: imageDataString)
                }
                card.kategori = remoteCard.kategori
                card.isFavorite = remoteCard.isFavorite
                card.userId = Int64(userId)
                card.deckId = UUID(uuidString: remoteCard.deckId)
            } catch {
                print("Error merging card: \(error)")
            }
        }
        
        saveContext()
    }
    
    private func mergeMealsFromBackend(_ remoteMeals: [RemoteMeal]) {
        guard let userId = self.userId else { return }
        
        let userMeals = remoteMeals.filter { $0.userId == userId }
        
        for remoteMeal in userMeals {
            let request = SavedMeal.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", remoteMeal.id)
            
            do {
                let existingMeals = try context.fetch(request)
                if existingMeals.isEmpty {
                    let newMeal = SavedMeal(context: context)
                    newMeal.id = UUID(uuidString: remoteMeal.id) ?? UUID()
                    newMeal.name = remoteMeal.name
                    newMeal.totalCarbs = remoteMeal.totalCarbs
                    newMeal.createdDate = remoteMeal.createdDate
                    
                    for remoteItem in remoteMeal.mealItems {
                        let newItem = SavedMealItem(context: context)
                        newItem.id = UUID(uuidString: remoteItem.id) ?? UUID()
                        newItem.name = remoteItem.name
                        newItem.amount = remoteItem.amount
                        newItem.calculatedCarbs = remoteItem.calculatedCarbs
                        newItem.meal = newMeal
                    }
                }
            } catch {
                print("Error merging meal: \(error)")
            }
        }
        
        saveContext()
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
    
     func clearLocalData() {
            let entities = ["Categories", "BrugerdefineredeKort", "SavedMeal", "SavedMealItem"]
            
            for entityName in entities {
                let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
                
                // Add userId filter if user is logged in
                if let userId = self.userId {
                    fetchRequest.predicate = NSPredicate(format: "userId == %d", userId)
                }
                
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                deleteRequest.resultType = .resultTypeObjectIDs
                
                do {
                    let result = try context.execute(deleteRequest) as? NSBatchDeleteResult
                    if let objectIDs = result?.result as? [NSManagedObjectID] {
                        let changes = [NSDeletedObjectsKey: objectIDs]
                        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
                    }
                    try context.save()
                    print("Successfully cleared \(entityName) from local storage")
                } catch {
                    print("Error clearing \(entityName): \(error)")
                }
            }
        }
    
}
