//
//  AllRecipesScreen.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 24.04.2024.
//

import SwiftUI
import Kingfisher

struct AllRecipesScreen: View {

    @EnvironmentObject private var nav: Navigation
    @StateObject var viewModel = RecipesViewModel()

    @State private var text: String = ""
    @State private var searchButtonTapped: Bool = false
    @State private var isLoading: Bool = false

    var body: some View {
        MainBlock
            .customTabBarItem(placement: .topBarTrailing, iconName: "slider.horizontal.3") {
                open(.editCategory)
            }
            .navigationDestination(for: Screens.self) { screen in
                switch screen {
                case let .detailed(recipe):
                    RecipeDetailScreen(recipe: recipe)
                        .customNavBar(title: .clear)
                        .backNavBarButton {
                            nav.openPreviousScreen()
                        }
                        .toolbarBackground(.hidden, for: .navigationBar)
                case .editCategory:
                    RecipeFiltersScreen(filterSettings: viewModel.searchFilters) { isFiltersUpdated in
                        if isFiltersUpdated {
                            updateSearch()
                        }
                    }
                }
            }
            .onAppear {
                if viewModel.recipes.isEmpty {
                    updateSearch()
                }
            }
            .onChange(of: text) {
                updateSearch()
            }
    }
}

// MARK: - Actions

extension AllRecipesScreen {

    func updateSearch() {
        guard !text.isEmpty else { return }

        Task {
            isLoading = true
            await viewModel.fetch(query: text, filterSettings: viewModel.searchFilters)

            withAnimation {
                isLoading = false
            }
        }
    }

    enum Screens: Hashable {
        case editCategory
        case detailed(recipe: Recipe)
    }

    func goBack() {
        nav.openPreviousScreen()
    }

    func open(_ screen: Screens) {
        nav.addScreen(screen: screen)
    }
}

// MARK: - UI Subviews

extension AllRecipesScreen {

    var MainBlock: some View {
        VStack {
            SearchBar(text: $text, searchButtonTapped: $searchButtonTapped)
                .frame(height: 60)

            RecipesGrid
                .overlay {
                    if isLoading {
                        GeometryReader { _ in }
                            .ignoresSafeArea()
                            .background(.background.opacity(0.8))

                        Loader()
                    }
                }
        }
        .padding(.top, .SPx1)
        .overlay {
            if viewModel.recipes.isEmpty, !text.isEmpty, !isLoading {
                ContentUnavailableView(
                    "No results for \"\(text)\"",
                    systemImage: "exclamationmark.magnifyingglass",
                    description: Text("Check the spelling or try a new search.")
                )
            }
        }
    }

    struct SearchBar: View {
        @Binding var text: String
        @Binding var searchButtonTapped: Bool
        @State var isEditing: Bool = false

        var body: some View {
            HStack {
                TextField("Search for something...", text: $text)
                    .padding()
                    .padding(.horizontal, .SPx6)
                    .background {
                        RoundedRectangle(cornerRadius: .CRx3)
                            .fill(.ultraThickMaterial)
                    }
                    .overlay {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.secondary)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)

                            if isEditing && !text.isEmpty {
                                Button {
                                    text = ""
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.secondary)
                                        .padding(.trailing)
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        isEditing = true
                    }
                    .onSubmit {
                        searchButtonTapped.toggle()
                    }
                if isEditing {
                    Button(action: {
                        isEditing = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }, label: {
                        Text("Cancel")
                    })
                    .padding(.trailing, .SPx2)
                }
            }
            .padding(.horizontal)
        }
    }

    var RecipesGrid: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(
                columns: Array(
                    repeating: GridItem(.flexible(), spacing: .SPx3),
                    count: viewModel.numberOfColumns
                ),
                spacing: .SPx1
            ) {
                ForEach(viewModel.recipes) { recipe in
                    VStack {
                        if viewModel.searchFilters.recipesShowKind.numberOfColumns == 1 {
                            RecipeCellHorizontal(recipe: recipe)
                        } else {
                            RecipeCellVertical(recipe: recipe)
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding(.horizontal)
    }

    func RecipeCellHorizontal(recipe: Recipe) -> some View {
        HStack {
            KFImage(recipe.image)
                .placeholder {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial)
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )

            VStack(alignment: .leading) {
                Text(recipe.label)
                    .headline
                    .lineLimit(2)

                DietLabels(recipe.dietLabels)

                Spacer()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(recipe.totalNutrients) { nutrient in
                            TagView(title: String(format: "%.0f", nutrient.quantity), image: nutrient.icon)
                        }
                    }
                }
            }
            .padding(.top, .SPx2)

            Spacer()
        }
        .onTapGesture {
            open(.detailed(recipe: recipe))
        }
    }

    func TagView(title: String, image: Image) -> some View {
        HStack {
            Text(title)
            image
                .resizable()
                .frame(edge: 16)
        }
        .frame(height: 20)
        .padding(.SPx2)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: .CRx5))
    }

    func DietLabels(_ dietLabels: [DietLabel]) -> some View {
        let text = dietLabels.map({ $0.rawValue }).joined(separator: ", ")
        return Text(text)
            .subheadline
            .foregroundColor(.secondary)
            .lineLimit(2)
    }

    func RecipeCellVertical(recipe: Recipe) -> some View {
        VStack(alignment: .center) {
            KFImage(recipe.image)
                .placeholder {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial)
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(edge: 160)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
            Text(recipe.label)
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                .frame(width: 160)
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            open(.detailed(recipe: recipe))
        }
    }
}

struct Loader: View {

    @State var animate: Bool = false

    var body: some View {

        VStack {
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(
                    AngularGradient.init(
                        gradient: .init(colors: [.green, .blue]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .frame(edge: 45)
                .rotationEffect(.init(degrees: animate ? 360 : 0))
                .animation(.linear(duration: 0.7).repeatForever(autoreverses: false), value: animate)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: .CRx5))
        .onAppear {
            animate.toggle()
        }
    }
}

#Preview {

    NavigationStack {
        AllRecipesScreen(viewModel: .init(searchFiltes: .init(recipesShowKind: .oneColumn)))
            .backNavBarButton { }
            .customNavBar(title: "Recipes")
    }
    .environmentObject(Navigation())
}
