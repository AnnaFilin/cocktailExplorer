//
//  CocktailExplorerApp.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 02/06/2025.
//

import SwiftUI

@main
struct CocktailExplorerApp: App {
    @StateObject private var drinksViewModel: DrinksViewModel
    @StateObject private var ingredientFilterViewModel: IngredientFilterViewModel
    @StateObject private var ingredientDetailsViewModel: IngredientDetailsViewModel
    @StateObject private var favoriteDrinksViewModel: FavoriteDrinksViewModel

    init() {
        let cocktailService = CocktailService()
        _drinksViewModel = StateObject(wrappedValue: DrinksViewModel(service: cocktailService))
        _ingredientFilterViewModel = StateObject(wrappedValue: IngredientFilterViewModel(service: cocktailService))
        _ingredientDetailsViewModel = StateObject(wrappedValue: IngredientDetailsViewModel(service: cocktailService))
        _favoriteDrinksViewModel = StateObject(wrappedValue: FavoriteDrinksViewModel(service: cocktailService))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(drinksViewModel)
                             .environmentObject(ingredientFilterViewModel)
                             .environmentObject(ingredientDetailsViewModel)
                             .environmentObject(favoriteDrinksViewModel)
        }
    }
}
