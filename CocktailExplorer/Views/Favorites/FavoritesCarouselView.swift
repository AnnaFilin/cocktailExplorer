//
//  FavoritesCarouselView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 19/06/2025.
//

import SwiftUI

struct FavoritesCarouselView: View {
    @EnvironmentObject var favoritsViewModel: FavoriteDrinksViewModel
    
    var filteredDrinks: [DrinkDetail] {
        if let selected = favoritsViewModel.selectedIngredient {
            return favoritsViewModel.favoriteDrinks.filter { drink in
                drink.ingredients.contains { $0.name == selected }
            }
        } else {
            return favoritsViewModel.favoriteDrinks
        }
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                ForEach(filteredDrinks, id: \.self) { drink in
                    NavigationLink(value: drink.id) {
                        DrinkCardView(drink: drink, width: ThemeSize.drinkCardWidth, height: ThemeSize.drinkCardHeight)
                            .frame(width: ThemeSize.drinkCardWidth, height: ThemeSize.drinkCardHeight)
                    }
                }
            }
        }
    }
    
}

#Preview {
    FavoritesCarouselView()
        .environmentObject(FavoriteDrinksViewModel(service: CocktailService()))
}
