//
//  FavoritesGridView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 18/06/2025.
//

import SwiftUI

struct FavoritesGridView: View {
    @EnvironmentObject var favoritsViewModel: FavoriteDrinksViewModel

    let columns = [
        GridItem(.flexible(), spacing: 16),
          GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Array(favoritsViewModel.favoriteDrinks), id: \.self) { drink in
//                    NavigationLink {
//                        DrinkDetailView(drinkId: drink.id, backgroundColor: $backgroundColor)
//                            .environmentObject(drinksViewModel)
//                    } label: {
                        DrinkCardView(drink: drink)
//                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 32)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    FavoritesGridView()
        .environmentObject(FavoriteDrinksViewModel())
}
