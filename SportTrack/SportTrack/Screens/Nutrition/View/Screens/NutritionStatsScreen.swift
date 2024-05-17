//
//  NutritionStatsScreen.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 02.05.2024.
//

import SwiftUI

struct NutritionStatsScreen: View {

    @EnvironmentObject private var nav: Navigation
    var eatenRecipes: [EatenRecipe]

    var body: some View {
        MainBlock
            .backNavBarButton {
                goBack()
            }
            .customNavBar(title: "Nutrition stats")
    }
}

// MARK: - Actions

extension NutritionStatsScreen {

    func goBack() {
        nav.openPreviousScreen()
    }
}

// MARK: - UI Subviews

extension NutritionStatsScreen {

    var MainBlock: some View {
        VStack {
            if eatenRecipes.isEmpty {
                ContentUnavailableView(
                    "Nothing eaten yet",
                    systemImage: "cup.and.saucer.fill",
                    description: Text("Choose something from recipes")
                )
            } else {
                ListOfEaten
            }
        }
    }

    var ListOfEaten: some View {
        List {
            Section {
                ForEach(eatenRecipes, id: \.id) { recipe in
                    EatenRecipeCell(recipe)
                        .frame(height: 100)
                }
            } header: {
                Text("Eaten")
                    .title3
            }
        }
    }

    func EatenRecipeCell(_ recipe: EatenRecipe) -> some View {
        VStack {
            HStack {
                ZStack {
                    AsyncImage(
                        url: URL(string: recipe.icon),
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                }
                .frame(edge: 60)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: .CRx2))

                VStack(alignment: .leading) {
                    Text(recipe.label)
                        .headline

                    ScrollView(.horizontal) {
                        HStack {
                            TagView(title: "\(recipe.nutrioionData.carbs)", image: recipe.nutrioionData.icon(for: .carbs))
                            TagView(title: "\(recipe.nutrioionData.fats)", image: recipe.nutrioionData.icon(for: .fat))
                            TagView(title: "\(recipe.nutrioionData.proteins)", image: recipe.nutrioionData.icon(for: .protein))
                            TagView(title: "\(recipe.nutrioionData.calories)", image: Image(uiImage: UIImage(systemName: "flame")!.withRenderingMode(.alwaysTemplate)))
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            Text(CustomDateFormatter.shared.dateFormatterMedium.string(from: recipe.date))
        }
    }

    func TagView(title: String, image: Image) -> some View {
        HStack {
            Text(title)
            image
                .resizable()
                .frame(edge: 16)
                .foregroundStyle(.primary)
        }
        .frame(height: 20)
        .padding(.SPx2)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: .CRx5))
    }
}

