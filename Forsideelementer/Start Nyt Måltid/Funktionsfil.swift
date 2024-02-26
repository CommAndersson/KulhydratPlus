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
    @Published var shouldNavigateBackToStartNytMåltid: Bool = false
    
    func addMealItem(flashcard: Flashcard, amount: Double, carbs: Double) {
        let newFlashcardNytMåltid = FlashcardNytMåltid(name: flashcard.navn, kulhydrat: flashcard.kulhydrat, måleenhed: flashcard.måleenhed, mængde: flashcard.mængde)
        let newMealItem = MealItem(flashcard: newFlashcardNytMåltid, amount: amount)
        DispatchQueue.main.async {
            self.mealItems.append(newMealItem)
            self.calculateTotalCarbs()
        }
    }
    
    private func calculateTotalCarbs() {
        DispatchQueue.main.async {
            self.totalCarbs = self.mealItems.reduce(0) { $0 + $1.calculatedCarbs }
        }
    }
}




