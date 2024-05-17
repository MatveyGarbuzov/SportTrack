//
//  NutritionScreen.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 13.04.2024.
//

import SwiftUI

struct NutritionScreen: View {

    @EnvironmentObject private var nav: Navigation
    @Environment(\.modelContext) private var modelContext

    @State var vm = NutritionViewModel()
    @State var nutritionsEatenToday: [NutritionData] = []
    @State var eatenRecipes: [EatenRecipe] = []
    @State var goalToEat: NutritionData = .init(calories: 0, proteins: 0, fats: 0, carbs: 0)
    @State var recipesEatenToday: [EatenRecipe] = []

    var body: some View {
        MainBlock
            .customNavBar(title: "Nutrition")
            .customTabBarItem(placement: .topBarLeading, iconName: "chart.bar.doc.horizontal") {
                open(.nutritionStats)
            }
            .customTabBarItem(placement: .topBarTrailing, iconName: "ruler") {
                open(.calculator)
            }
            .navigationDestination(for: Screens.self) { screen in
                switch screen {
                case .allRecipes:
                    AllRecipesScreen()
                        .customNavBar(title: "Recipes")
                        .backNavBarButton {
                            goBack()
                        }
                case .calculator:
                    NutritionCalculator() { newGoal in
                        guard let newGoal else { return }

                        vm.saveNutritonGoal(newGoal)
                    }
                case .nutritionStats:
                    NutritionStatsScreen(eatenRecipes: eatenRecipes)
                }
            }
            .onAppear {
                fetchData()
                updateEatenToday()
            }
    }
}

// MARK: - Actions

extension NutritionScreen {

    func fetchData() {
        vm.context = modelContext
        eatenRecipes = vm.getEatenRecipes()
        goalToEat = vm.getNutritionGoal()
    }

    func updateEatenToday() {
        recipesEatenToday = eatenRecipes.filter { CustomDateFormatter.shared.isToday(date: $0.date) }
        nutritionsEatenToday = recipesEatenToday.map { $0.nutrioionData }
    }

    enum Screens: Hashable {
        case allRecipes
        case calculator
        case nutritionStats
    }

    func goBack() {
        nav.openPreviousScreen()
    }

    func open(_ screen: Screens) {
        nav.addScreen(screen: screen)
    }
}

// MARK: - UI Subviews

extension NutritionScreen {

    var MainBlock: some View {
        VStack(spacing: 0) {
            CaloriesProgressCircle
            NutritionInfoViews
            ListOfEatenToday
        }
        .overlay(alignment: .bottom) {
            IconButton(iconName: "plus", size: .init(width: 60, height: 60)) {
                open(.allRecipes)
            }
            .background(.ultraThinMaterial)
            .clipShape(Circle())
            .padding(.bottom, .tabBarSpacing)
        }
    }
}

#Preview {
    NutritionScreen()
}
