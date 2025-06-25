//
//  FavoritesButtonView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 03/06/2025.
//

import SwiftUI

struct FavoritesButtonView: View {
    @EnvironmentObject var drinksViewModel: DrinksViewModel
    
    let drinkId: String
    
    var body: some View {
        Button(action: {
            if drinksViewModel.favoriteDrinkIDs.contains(drinkId) {
                drinksViewModel.removeDrink(drinkId)
            } else {
                drinksViewModel.addDrink(drinkId)
            }
            
        }, label: {
            Image(systemName: drinksViewModel.favoriteDrinkIDs.contains(drinkId) ? "heart.fill" : "heart")

        })
     
    }
}

#Preview {
    FavoritesButtonView(drinkId: "14029")
        .environmentObject(DrinksViewModel.preview)
}
