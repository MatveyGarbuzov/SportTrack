//
//  ListOfRecipes.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 23.04.2024.
//

import SwiftUI

extension NutritionScreen {

    var CaloriesProgressCircle: some View {
        CircularProgressView(
            eaten: nutritionsEatenToday.reduce(0) { $0 + $1.calories },
            goalToEat: goalToEat.calories
        )
        .frame(edge: 200)
        .padding()
    }

    var NutritionInfoViews: some View {
        HStack {
            NutritionInfoView(titleKind: .carbs, eaten: nutritionsEatenToday.reduce(0) { $0 + $1.carbs }, goalToEat: goalToEat.carbs)
            NutritionInfoView(titleKind: .fat, eaten: nutritionsEatenToday.reduce(0) { $0 + $1.fats }, goalToEat: goalToEat.fats)
            NutritionInfoView(titleKind: .protein, eaten: nutritionsEatenToday.reduce(0) { $0 + $1.proteins }, goalToEat: goalToEat.proteins)
        }
    }

    var ListOfEatenToday: some View {
        List {
            Section {
                if recipesEatenToday.isEmpty {
                    ContentUnavailableView(
                        "Nothing eaten yet today",
                        systemImage: "cup.and.saucer.fill",
                        description: Text("Choose something from recipes")
                    )
                } else {
                    ForEach(recipesEatenToday, id: \.id) { recipe in
                        EatenRecipeCell(recipe)
                            .frame(height: 70)
                    }
                    .onDelete(perform: delete)
                }

            } header: {
                Text("Eaten today")
                    .title3
            }
        }
    }

    func delete(at offsets: IndexSet) {
        let idsToDelete = offsets.map { self.recipesEatenToday[$0].id }

        idsToDelete.forEach { UUID in
            vm.deleteEatenRecipe(by: UUID)
        }
        fetchData()
        updateEatenToday()
    }

    func EatenRecipeCell(_ recipe: EatenRecipe) -> some View {
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

#Preview {
    NutritionScreen()
}

