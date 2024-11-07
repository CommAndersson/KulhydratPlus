//
//  MealModelsAPI.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 06/11/2024.
//

/*
// MealModels.swift
import Foundation

struct SavedMeal: Codable, Identifiable {
    let id: String
    let name: String
    let totalCarbs: Double
    let createdDate: Date
    let userId: Int
    var mealItems: [SavedMealItem]
}

struct SavedMealItem: Codable, Identifiable {
    let id: String
    let name: String
    let amount: Double
    let calculatedCarbs: Double
}

// APIClient.swift
class APIClient {
    static let shared = APIClient()
    private let baseURL = "YOUR_BACKEND_URL" // e.g., "http://localhost:3000/api"
    private var authToken: String {
        // Get token from UserDefaults or your auth service
        UserDefaults.standard.string(forKey: "authToken") ?? ""
    }
    
    enum APIError: Error {
        case invalidURL
        case noData
        case decodingError
        case serverError(String)
        case unauthorized
    }
    
    private func createRequest(_ endpoint: String, method: String = "GET", body: Data? = nil) -> URLRequest {
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.path += endpoint
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            request.httpBody = body
        }
        
        return request
    }
    
    func fetchMeals() async throws -> [SavedMeal] {
        let request = createRequest("/meals")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.serverError("Invalid response")
        }
        
        switch httpResponse.statusCode {
        case 200:
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([SavedMeal].self, from: data)
        case 401:
            throw APIError.unauthorized
        default:
            throw APIError.serverError("Server returned status code \(httpResponse.statusCode)")
        }
    }
    
    func saveMeal(name: String, totalCarbs: Double, items: [MealItem]) async throws -> SavedMeal {
        let mealData = [
            "name": name,
            "totalCarbs": totalCarbs,
            "items": items.map { [
                "name": $0.name,
                "amount": $0.amount,
                "calculatedCarbs": $0.calculatedCarbs
            ]}
        ] as [String: Any]
        
        let jsonData = try JSONSerialization.data(withJSONObject: mealData)
        let request = createRequest("/meals", method: "POST", body: jsonData)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.serverError("Invalid response")
        }
        
        switch httpResponse.statusCode {
        case 200, 201:
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(SavedMeal.self, from: data)
        case 401:
            throw APIError.unauthorized
        default:
            throw APIError.serverError("Server returned status code \(httpResponse.statusCode)")
        }
    }
    
    func deleteMeal(id: String) async throws {
        let request = createRequest("/meals/\(id)", method: "DELETE")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.serverError("Invalid response")
        }
        
        switch httpResponse.statusCode {
        case 200, 204:
            return
        case 401:
            throw APIError.unauthorized
        default:
            throw APIError.serverError("Server returned status code \(httpResponse.statusCode)")
        }
    }
}

// SavedMealsManager.swift
@MainActor
class SavedMealsManager: ObservableObject {
    @Published var savedMeals: [SavedMeal] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    func fetchMeals() {
        Task {
            isLoading = true
            do {
                savedMeals = try await APIClient.shared.fetchMeals()
                error = nil
            } catch {
                self.error = error
                print("Error fetching meals: \(error)")
            }
            isLoading = false
        }
    }
    
    func saveMeal(name: String, totalCarbs: Double, items: [MealItem]) {
        Task {
            do {
                let meal = try await APIClient.shared.saveMeal(name: name, totalCarbs: totalCarbs, items: items)
                savedMeals.insert(meal, at: 0)
                error = nil
            } catch {
                self.error = error
                print("Error saving meal: \(error)")
            }
        }
    }
    
    func deleteMeal(_ meal: SavedMeal) {
        Task {
            do {
                try await APIClient.shared.deleteMeal(id: meal.id)
                savedMeals.removeAll { $0.id == meal.id }
                error = nil
            } catch {
                self.error = error
                print("Error deleting meal: \(error)")
            }
        }
    }
}

*/
