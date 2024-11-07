//
//  Favoritter funktioner.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 22/09/2024.
//

import SwiftUI
import Combine
import CoreData

class FavoritesManager: NSObject, ObservableObject {
    @Published var favoriteItems: [FavoriteItem] = []

    private let context = PersistenceController.shared.container.viewContext
    private var fetchedResultsController: NSFetchedResultsController<BrugerdefineredeKort>!

    override init() {
        super.init()
        setupFetchedResultsController()
        updateFavorites()
    }

    private func setupFetchedResultsController() {
        let fetchRequest: NSFetchRequest<BrugerdefineredeKort> = BrugerdefineredeKort.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isFavorite == true")
        fetchRequest.sortDescriptors = []

        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )

        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
            print("Successfully performed initial fetch")
        } catch {
            print("Failed to fetch BrugerdefineredeKort favorites: \(error.localizedDescription)")
        }
    }

    func addCategoryItemToFavorites(_ item: any CategoryItem) {
        let favoriteItem = FavoriteCategoryItemID(context: context)
        favoriteItem.itemId = item.id
        saveContext()
        updateFavorites()
    }

    func removeCategoryItemFromFavorites(_ item: any CategoryItem) {
        let fetchRequest: NSFetchRequest<FavoriteCategoryItemID> = FavoriteCategoryItemID.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "itemId == %@", item.id as CVarArg)

        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                context.delete(object)
            }
            saveContext()
            updateFavorites()
        } catch {
            print("Failed to remove favorite: \(error.localizedDescription)")
        }
    }

    func isFavorite(_ item: any CategoryItem) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteCategoryItemID> = FavoriteCategoryItemID.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "itemId == %@", item.id as CVarArg)

        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Failed to check if item is favorite: \(error.localizedDescription)")
            return false
        }
    }

    func addBrugerdefineredeKortToFavorites(_ card: BrugerdefineredeKort) {
        card.isFavorite = true
        saveContext()
    }

    func removeBrugerdefineredeKortFromFavorites(_ card: BrugerdefineredeKort) {
        card.isFavorite = false
        saveContext()
    }

    func isFavorite(_ card: BrugerdefineredeKort) -> Bool {
        return card.isFavorite
    }

    func updateFavorites() {
        print("Starting updateFavorites")
        
        // Retrieve all predefined items
        let allCategoryItems = getAllPredefinedCategoryItems()
        print("Got predefined items: \(allCategoryItems.count)")
        
        let favoriteCategoryItems = allCategoryItems.filter { isFavorite($0) }
        print("Filtered favorite category items: \(favoriteCategoryItems.count)")

        // Retrieve user-created favorites with additional safety checks
        let brugerdefineredeKortItems = (fetchedResultsController.fetchedObjects ?? []).filter { card in
            return card.managedObjectContext != nil && !card.isDeleted
        }
        print("Got valid brugerdefinedeKort items: \(brugerdefineredeKortItems.count)")

        // Combine both types into the favoriteItems array
        DispatchQueue.main.async {
            self.favoriteItems = favoriteCategoryItems.map { FavoriteItem.categoryItem($0) } +
                brugerdefineredeKortItems.map { FavoriteItem.brugerdefineredeKort($0) }
            print("Total favorite items: \(self.favoriteItems.count)")
        }
    }

    private func getAllPredefinedCategoryItems() -> [any CategoryItem] {
        return baelgfrugterData + fastFoodData + frugtData + rodfrugtData + grøntsagerData + cakeData + breadData
    }

    private func saveContext() {
        do {
            try context.save()
            print("Context saved successfully")
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
}

extension FavoritesManager: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("FetchedResultsController detected changes")
        updateFavorites()
    }
}

enum FavoriteItem: Identifiable {
    case categoryItem(any CategoryItem)
    case brugerdefineredeKort(BrugerdefineredeKort)

    var id: String {
        switch self {
        case .categoryItem(let item):
            return item.id.uuidString
        case .brugerdefineredeKort(let card):
            return card.objectID.uriRepresentation().absoluteString
        }
    }

    var name: String {
        switch self {
        case .categoryItem(let item):
            return item.Navn
        case .brugerdefineredeKort(let card):
            return card.navn ?? "No Name"
        }
    }

    var image: Image {
        switch self {
        case .categoryItem(let item):
            return Image(item.Billede)
        case .brugerdefineredeKort(let card):
            if let imageData = card.imageData, let uiImage = UIImage(data: imageData) {
                return Image(uiImage: uiImage)
            } else {
                return Image("Placeholder")
            }
        }
    }
}

extension FavoriteItem {
    var nameFirstLetter: String {
        return String(self.name.prefix(1)).uppercased()
    }
}
