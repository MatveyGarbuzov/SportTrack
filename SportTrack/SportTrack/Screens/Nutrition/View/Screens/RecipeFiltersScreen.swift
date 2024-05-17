//
//  RecipeFiltersScreen.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 27.04.2024.
//

import SwiftUI

struct RecipeFiltersScreen: View {

    @EnvironmentObject private var nav: Navigation
    @StateObject var filterSettings: FilterSettings
    @State private var initialFilterSettings: FilterSettings = FilterSettings()
    var isFiltersUpdated: (Bool) -> Void

    var body: some View {
        MainBlock
            .customNavBar(title: "Filters")
            .backNavBarButton {
                goBack()
            }
            .checkmarkNavBarButton {
                if
                    initialFilterSettings.dietLabel != filterSettings.dietLabel ||
                        initialFilterSettings.cuisineType != filterSettings.cuisineType
                {
                    isFiltersUpdated(true)
                } else {
                    isFiltersUpdated(false)
                }
                goBack()
            }
            .onAppear {
                self.initialFilterSettings = FilterSettings(
                    recipesShowKind: filterSettings.recipesShowKind,
                    cuisineType: filterSettings.cuisineType,
                    dietLabel: filterSettings.dietLabel
                )
            }
    }
}

// MARK: - Actions

extension RecipeFiltersScreen {

    func goBack() {
        nav.openPreviousScreen()
    }
}

class FilterSettings: ObservableObject {
    var recipesShowKind: RecipesShowKind
    @Published var cuisineType: CuisineType
    @Published var dietLabel: DietLabel

    init(
        recipesShowKind: RecipesShowKind = .oneColumn,
        cuisineType: CuisineType = .american,
        dietLabel: DietLabel = .balanced
    ) {
        self.recipesShowKind = recipesShowKind
        self.cuisineType = cuisineType
        self.dietLabel = dietLabel
    }
}

extension FilterSettings: Hashable {
    static func == (lhs: FilterSettings, rhs: FilterSettings) -> Bool {
        lhs.recipesShowKind == rhs.recipesShowKind && lhs.cuisineType == rhs.cuisineType && lhs.dietLabel == rhs.dietLabel
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(recipesShowKind)
        hasher.combine(cuisineType)
        hasher.combine(dietLabel)
    }
}

// MARK: - UI Subviews

extension RecipeFiltersScreen {

    var MainBlock: some View {
        Form {
            RecipesShowKindPicker
            CuisineTypePicker
            DietTypePicker
        }
    }

    var RecipesShowKindPicker: some View {
        Section {
            Picker("", selection: $filterSettings.recipesShowKind) {
                ForEach(RecipesShowKind.allCases) { kind in
                    if let catUIImage = ImageRenderer(content: Image(systemName: kind.rawValue)).uiImage {
                        Image(uiImage: catUIImage)
                            .tag(kind)
                    }
                }
            }
            .pickerStyle(.segmented)
        } header: {
            Text("Presentation")
        }
    }

    var CuisineTypePicker: some View {
        CollapsibleInlinePicker(title: "Cuisine type: \(filterSettings.cuisineType.rawValue.capitalized)", selection: $filterSettings.cuisineType) {
            ForEach(CuisineType.allCases, id: \.id) { kind in
                Text(kind.rawValue.capitalized)
                    .tag(kind)
            }
        }
    }

    var DietTypePicker: some View {
        CollapsibleInlinePicker(title: "Diet type: \(filterSettings.dietLabel.rawValue.capitalized)", selection: $filterSettings.dietLabel) {
            ForEach(DietLabel.allCases, id: \.id) { kind in
                Text(kind.rawValue.capitalized)
                    .tag(kind)
            }
        }
    }
}

enum RecipesShowKind: String/*CaseIterable*/ {
    case oneColumn = "rectangle.grid.1x2.fill"
    case twoColumms = "square.grid.2x2.fill"
}

extension RecipesShowKind {

    var numberOfColumns: Int {
        switch self {
        case .oneColumn: 1
        case .twoColumms: 2
        }
    }
}

extension RecipesShowKind: CaseIterable, Identifiable {
    var id: String { return self.rawValue }
}

#Preview {
    NavigationStack {
        RecipeFiltersScreen(filterSettings: FilterSettings(recipesShowKind: .twoColumms, cuisineType: .american)) { _ in }
    }
    .environmentObject(Navigation())
}
