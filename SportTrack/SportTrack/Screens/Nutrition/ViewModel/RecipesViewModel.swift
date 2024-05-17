//
//  RecipesViewModel.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 25.04.2024.
//

import Foundation

@MainActor
class RecipesViewModel: ObservableObject {

    @Published var recipes: [Recipe]
    @Published var searchFilters: FilterSettings

    init(recipes: [Recipe] = [], searchFiltes: FilterSettings = FilterSettings(recipesShowKind: .twoColumms)) {
        self.recipes = recipes
        self.searchFilters = searchFiltes
    }
}

extension RecipesViewModel {

    var numberOfColumns: Int {
        searchFilters.recipesShowKind.numberOfColumns
    }
}

// MARK: - CRUD

extension RecipesViewModel {

    func fetch(query: String, filterSettings: FilterSettings) async {
        guard let urlString = createURL(query: query, filterSettings: filterSettings) else { return }
        print("fetch: \(urlString)")
        guard let downloadedData: QueryAPI = await NetworkService().fetch(fromString: urlString) else { return }

        recipes = downloadedData.hits.map { $0.recipe.mapper }

        
        print("FETCHED: \(recipes.count)")
    }

    func createURL(query: String, filterSettings: FilterSettings, from: Int = 0, to: Int = 100) -> String? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.edamam.com"
        urlComponents.path = "/search"

        urlComponents.queryItems = [
            .init(name: "q", value: query),
            .init(name: "from", value: String(from)),
            .init(name: "to", value: String(to)),
            .init(name: "app_id", value: "1977fbb1"),
            .init(name: "app_key", value: "3381850ed5cca71349db42e69038c295"),
        ]
        if filterSettings.cuisineType.rawValue != "Any" {
            urlComponents.queryItems?.append(.init(name: "cuisineType", value: filterSettings.cuisineType.rawValue))
        }
        if filterSettings.dietLabel.rawValue != "Any" {
            urlComponents.queryItems?.append(.init(name: "dietLabel", value: filterSettings.dietLabel.rawValue))
        }

        return urlComponents.string
    }
}

extension String {

    static let mockURL = "https://api.edamam.com/search?q=breakfast&from=0&to=1&app_id=1977fbb1&app_key=3381850ed5cca71349db42e69038c295&health=vegetarian"
}
