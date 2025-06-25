//
//  FavoritesMiniScrollView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 19/06/2025.
//

import SwiftUI

struct FavoritesMiniScrollView: View {
    @EnvironmentObject var favoritsViewModel: FavoriteDrinksViewModel
    @Binding var selectedIngredientName: IdentifiableString?

    var body: some View {
   
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(Array(favoritsViewModel.ingredientFrequency.keys.sorted()), id: \.self) { ingredientName in
                    IngredientMiniCardView(selectedIngredientName: $selectedIngredientName, ingredientName: ingredientName)
                        .frame(width: 110, height: 130)
                }
            }
            .padding(.horizontal, ThemeSpacing.horizontal)
        }
    }
}


#Preview {
    FavoritesMiniScrollView(selectedIngredientName:  .constant(IdentifiableString(id: "Tequila")))
        .environmentObject(FavoriteDrinksViewModel())
}
