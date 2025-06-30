//
//  ContentView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 02/06/2025.
//

import SwiftUI

enum Tab {
    case search
    case favorites
    case random
    case mixBy
}

struct ContentView: View {
    @EnvironmentObject var drinksViewModel: DrinksViewModel
    @EnvironmentObject var ingredientFilterViewModel: IngredientFilterViewModel
    @EnvironmentObject var ingredientDetailsViewModel: IngredientDetailsViewModel
    @EnvironmentObject var favoriteDrinksViewModel: FavoriteDrinksViewModel
    @State var selectedTab: Tab = .search
    
    
    @State private var backgroundColor: Color = .backgroundLight
    
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .search:
                    DrinksGalleryView(backgroundColor: $backgroundColor)
                case .random:
                    RandomDrinkView(backgroundColor: $backgroundColor)
                case .mixBy:
                    MixLabView(backgroundColor: $backgroundColor)
                        .environmentObject(ingredientDetailsViewModel)
                        .environmentObject(ingredientFilterViewModel)
                case .favorites:
                    FavoritesView(backgroundColor: $backgroundColor)
                        .environmentObject(favoriteDrinksViewModel)
                        .environmentObject(ingredientDetailsViewModel)
                }
            }
            .environmentObject(drinksViewModel)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            TabBarBackgroundView(selectedTab: $selectedTab, backgroundColor: $backgroundColor)
        }
        .onAppear {
            //                UserDefaults.standard.removeObject(forKey: "FavoriteDrinksDetails")
            Task {
                if drinksViewModel.drinks.isEmpty {
                    
                    await drinksViewModel.startLoadingDrinks()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DrinksViewModel.preview)
        .environmentObject(IngredientFilterViewModel.preview)
        .environmentObject(IngredientDetailsViewModel.preview)
        .environmentObject(FavoriteDrinksViewModel.preview)
}
