//
//  Funktionsfil.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 22/02/2024.
//

import SwiftUI

class MealViewModel: ObservableObject {
    @Published var mealItems: [MealItem] = []{
        didSet {
            recalculateTotalCarbs()
            
        }
    }
    @Published var totalCarbs: Double = 0
    @Published var shouldNavigateBackToStartNytMåltid: Bool = false
    
    
    func addMealItem(flashcard: Flashcard, amount: Double, carbs: Double) {
        let newFlashcardNytMåltid = FlashcardNytMåltid(
            name: flashcard.navn,
            kulhydrat: carbs, // Assuming carbs is calculated based on amount and flashcard's details.
            måleenhed: flashcard.måleenhed,
            mængde: amount
            
        )
        
        let newMealItem = MealItem(
            flashcard: newFlashcardNytMåltid,
            amount: amount
            
        )
        
        DispatchQueue.main.async {
            self.mealItems.append(newMealItem)
            self.calculateTotalCarbs()
        }
    }
    
    // Function to add a meal item from any CategoryItem.
    func addMealItem(_ mealItem: MealItem) {
        DispatchQueue.main.async {
            self.mealItems.append(mealItem)
            self.recalculateTotalCarbs()
        }
    }
    private func calculateTotalCarbs() {
        DispatchQueue.main.async {
            self.totalCarbs = self.mealItems.reduce(0) { $0 + $1.calculatedCarbs }
        }
    }
    
    
    func recalculateTotalCarbs() {
        totalCarbs = mealItems.reduce(0) { $0 + $1.calculatedCarbs }
    }
    
    func removeMealItems(at offsets: IndexSet) {
        mealItems.remove(atOffsets: offsets)
        recalculateTotalCarbs()
    }
}

