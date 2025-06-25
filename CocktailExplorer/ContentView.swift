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
    @StateObject private var favoriteDrinksViewModel = FavoriteDrinksViewModel()
    @StateObject private var ingredientDetailsViewModel = IngredientDetailsViewModel()
    @EnvironmentObject var drinksViewModel: DrinksViewModel
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
                case .favorites:
                    FavoritesView(backgroundColor: $backgroundColor)
                        .environmentObject(favoriteDrinksViewModel)
                        .environmentObject(ingredientDetailsViewModel)
                        
                }
            }
            .environmentObject(drinksViewModel)
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            TabBarBackgroundView(selectedTab: $selectedTab, backgroundColor: $backgroundColor)
                .padding(.bottom, 0)
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
        .environmentObject(DrinksViewModel())
}
