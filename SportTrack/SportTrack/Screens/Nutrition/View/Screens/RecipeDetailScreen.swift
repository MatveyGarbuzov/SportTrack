//
//  RecipeDetailScreen.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 26.04.2024.
//

import SwiftUI
import Kingfisher

struct RecipeDetailScreen: View {

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var nav: Navigation
    @State private var isShowingShare = false
    @State private var isShowingFullRecipe = false
    @State private var isShowingAddRecipe = false
    @State private var gram: Int = 100

    @Environment(\.modelContext) private var modelContext
    @State private var vm = NutritionViewModel()

    let recipe: Recipe

    var body: some View {
        MainBlock
            .customTabBarItem(placement: .topBarTrailing, iconName: "square.and.arrow.up", withBackground: true) {
                guard URL(string: recipe.shareAs) != nil else { return }
                isShowingShare.toggle()
            }
            .sheet(isPresented: $isShowingShare) {
                // TODO: Не стрельнет?
                SFSafariViewWrapper(url: URL(string: recipe.shareAs)!)
                    .ignoresSafeArea()
            }
            .sheet(isPresented: $isShowingFullRecipe) {
                SFSafariViewWrapper(url: URL(string: recipe.url)!)
                    .ignoresSafeArea()
            }
            .alert("Enter amount of grams", isPresented: $isShowingAddRecipe) {
                TextField("0", value: $gram, format: .number)
                    .customizedTextField()
                    .keyboardType(.numberPad)
                Button("OK", action: closeAllScreens)
                Button("Cancel", role: .cancel) { dismiss() }
            } message: {
                Text("This data will be saved in your nutrition.")
            }
            .onAppear {
                vm.context = modelContext
            }
    }
}

// MARK: - Actions

extension RecipeDetailScreen {

    func closeAllScreens() {
        vm.saveEatenRecipe(
            recipe: EatenRecipe(
                id: UUID(),
                label: recipe.label,
                icon: recipe.image.absoluteString,
                source: recipe.source,
                grams: gram,
                nutrioionData: getNutritonData()
            )
        )
        nav.removeAll()
    }

    func getNutritonData() -> NutritionData {
        var nutritionData = NutritionData(calories: 0, proteins: 0, fats: 0, carbs: 0)
        let totalWeight = recipe.totalWeight

        nutritionData.calories = Int(recipe.calories / totalWeight * Double(gram))
        recipe.totalNutrients.forEach { total in
            let count = Int(total.quantity / totalWeight * Double(gram))

            if total.label == .protein {
                nutritionData.proteins = count
            }
            else if total.label == .fat {
                nutritionData.fats = count
            }
            else if total.label == .carbs {
                nutritionData.carbs = count
            }
        }

        return nutritionData
    }
}

// MARK: - UI Subviews

extension RecipeDetailScreen {

    var MainBlock: some View {
        ScrollView {
            VStack(spacing: 0) {
                BackgroundHeader(color: .red, subColor: .blue)

                VStack(alignment: .leading) {
                    Label
                    KcalLabel
                    NutrientInfoViews
                    Ingredients
                    ActionsButtonsStack
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: .CRx4))
            }
        }
        .scrollIndicators(.never)
        .ignoresSafeArea()
    }

    func BackgroundHeader(color: Color, subColor: Color) -> some View {
        GeometryReader { geometry in
            let minY = geometry.frame(in: .global).minY
            let percent = minY / 1.2 / 100
            let opacity = abs(percent)
            let blur = opacity * 3
            let scaleEffect = min(max(1, abs(percent) + 1), 1.3)

            ZStack {
                KFImage(recipe.image)
                    .resizable()
                    .frame(width: geometry.size.width, height: 300)
                    .scaledToFit()
                    .blur(radius: blur)
                    .scaleEffect(scaleEffect)
            }
            .clipShape(.rect(cornerRadius: .CRx4))
            .offset(y: -minY)
        }
        .frame(height: 300)
        .padding(.bottom)
    }

    var Label: some View {
        Text(recipe.label)
            .title2
            .lineLimit(2)
    }

    var KcalLabel: some View {
        HStack(spacing: .SPx1) {
            SwiftUI.Label(String(format: "%.0f", recipe.calories), systemImage: "flame.fill")
            Text("kcal")
                .padding(.trailing)


            SwiftUI.Label(String(format: "%.0f", recipe.totalWeight), systemImage: "scalemass.fill")
            Text("g")
        }
    }

    var NutrientInfoViews: some View {
        HStack {
            ForEach(recipe.totalNutrients) { nutrient in
                NutrientCell(nutrient: nutrient)
            }
        }
    }

    func NutrientCell(nutrient: Total) -> some View {
        VStack {
            nutrient.icon
                .resizable()
                .frame(edge: 24)

            HStack(alignment: .lastTextBaseline, spacing: 0) {
                Text(String(Int(nutrient.quantity)))
                    .font(.body)
                Text(nutrient.unit.rawValue)
                    .font(.callout)
            }

            Text(LocalizedStringKey(nutrient.label.rawValue))
                .headline
        }
        .frame(maxWidth: .infinity)
        .padding(.SPx2)
        .background(nutrient.label.color.opacity(0.7))
        .clipShape(
            RoundedRectangle(cornerRadius: .CRx4)
        )
    }

    var Ingredients: some View {
        GroupBox {
            VStack(alignment: .leading) {
                GroupBox {
                    Text("Ingredients")
                }

                HStack {
                    VStack(alignment: .leading) {
                        ForEach(recipe.ingredients, id: \.self) { ingredientLine in
                            Text(String.bullet).bold() + Text(String.space) + Text(ingredientLine).foregroundStyle(.secondary)
                        }
                    }
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
        }
        .groupBoxStyle(.automatic)
    }

    var ActionsButtonsStack: some View {
        HStack {
            BorderButton(title: "Show recipe") {
                isShowingFullRecipe.toggle()
            }
            FillButton(title: "Add") {
                isShowingAddRecipe.toggle()
            }
        }
    }
}

private extension RecipeDetailScreen {

    enum Constants {
        static let buttonsStackHeight: CGFloat = 60
        static let exerciseCellHeight: CGFloat = 70

        static func backgroundHeaderHeight(_ screenHeight: CGFloat) -> CGFloat { screenHeight * 0.55 }
    }
}
