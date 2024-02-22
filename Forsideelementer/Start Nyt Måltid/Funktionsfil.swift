//
//  Funktionsfil.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 22/02/2024.
//

import SwiftUI

class MealViewModel: ObservableObject {
    @Published var mealItems: [MealItem] = []
    @Published var totalCarbs: Double = 0

    func addMealItem(flashcard: Flashcard, amount: Double, carbs: Double) {
        // Ensure FlashcardNytMåltid is initialized correctly with the properties available in Flashcard
        let newFlashcardNytMåltid = FlashcardNytMåltid(name: flashcard.navn, carbohydratePer100g: flashcard.kulhydrat) // Adjust property names as necessary
        
        let newMealItem = MealItem(flashcard: newFlashcardNytMåltid, amount: amount)
        // Assuming calculatedCarbs is computed within MealItem based on amount and carbohydratePer100g
        
        mealItems.append(newMealItem)
        calculateTotalCarbs()
    }

    private func calculateTotalCarbs() {
        totalCarbs = mealItems.reduce(0) { $0 + $1.calculatedCarbs }
    }
}
