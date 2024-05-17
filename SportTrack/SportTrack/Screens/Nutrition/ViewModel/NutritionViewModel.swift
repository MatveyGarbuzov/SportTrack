//
//  NutritionViewModel.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 02.05.2024.
//

import SwiftUI
import SwiftData
import Observation

@Observable
final class NutritionViewModel {
    var context: ModelContext!

    func getNutrition() -> [NutritionData] {
        let fetchDescriptor = FetchDescriptor<SDNutritionData>()
        let nutritions = (try? context.fetch(fetchDescriptor)) ?? []
        return nutritions.map {
            NutritionData(
                id: $0._id,
                calories: $0._calories,
                proteins: $0._proteins,
                fats: $0._fats,
                carbs: $0._carbs
            )
        }
    }

    func saveNutritonGoal(_ goal: NutritionData) {
        UserDefaults.standard.set(goal.id.uuidString, forKey: "NutritonGoal")

        saveNutrition(nutrition: goal)
    }

    func getNutritionGoal() -> NutritionData {
        guard let goalID = UserDefaults.standard.string(forKey: "NutritonGoal"), let uuid = UUID(uuidString: goalID) else {
            return NutritionData(calories: 0, proteins: 0, fats: 0, carbs: 0)
        }

        return getNutrition(by: uuid) ?? NutritionData(calories: 0, proteins: 0, fats: 0, carbs: 0)
    }

    func getNutrition(by id: UUID) -> NutritionData? {
        let fetchDescriptor = FetchDescriptor(predicate: #Predicate<SDNutritionData> {
            $0._id == id
        })
        guard let sdNutrition = try? context.fetch(fetchDescriptor).first else {
            return nil
        }

        return NutritionData(
            id: sdNutrition._id,
            calories: sdNutrition._calories,
            proteins: sdNutrition._proteins,
            fats: sdNutrition._fats,
            carbs: sdNutrition._carbs
        )
    }

    func saveNutrition(nutrition: NutritionData) {
        let sdNutrition = SDNutritionData(
            id: nutrition.id,
            calories: nutrition.calories,
            proteins: nutrition.proteins,
            fats: nutrition.fats,
            carbs: nutrition.carbs
        )
        context.insert(sdNutrition)
        try? context.save()
    }

    func saveEatenRecipe(recipe: EatenRecipe) {
        var nutrioionData: NutritionData { recipe.nutrioionData }
        let dsNutritionData = SDNutritionData(
            id: nutrioionData.id,
            calories: nutrioionData.calories,
            proteins: nutrioionData.proteins,
            fats: nutrioionData.fats,
            carbs: nutrioionData.carbs
        )
        let sdEatenRecipe = SDEatenRecipe(
            id: recipe.id,
            label: recipe.label,
            icon: recipe.icon,
            source: recipe.source,
            grams: recipe.grams,
            nutrioionData: dsNutritionData
        )
        context.insert(sdEatenRecipe)
        try? context.save()
    }

    func getEatenRecipes() -> [EatenRecipe] {
        let fetchDescriptor = FetchDescriptor<SDEatenRecipe>()
        let sdRecipes = (try? context.fetch(fetchDescriptor)) ?? []

        return sdRecipes.map { recipe in
            EatenRecipe(
                id: recipe._id,
                label: recipe._label,
                icon: recipe._icon,
                source: recipe._source,
                grams: recipe._grams,
                nutrioionData: NutritionData(
                    id: recipe._nutrioionData._id,
                    calories: recipe._nutrioionData._calories,
                    proteins: recipe._nutrioionData._proteins,
                    fats: recipe._nutrioionData._fats,
                    carbs: recipe._nutrioionData._carbs
                )
            )
        }
    }

    func deleteEatenRecipe(by id: UUID) {
        do {
            try context.delete(model: SDEatenRecipe.self, where: #Predicate { $0._id == id })
        } catch {
            print(error.localizedDescription)
        }
    }
}
