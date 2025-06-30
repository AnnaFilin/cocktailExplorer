//
//  FavoritesMiniScrollView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 19/06/2025.
//

// TODO: unify opacity for all ingredient chips in Favorites carousel
import SwiftUI

struct FavoritesMiniScrollView: View {
    @EnvironmentObject var favoritsViewModel: FavoriteDrinksViewModel
    @Binding var selectedIngredientName: IdentifiableString?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                ForEach(Array(favoritsViewModel.ingredientFrequency.keys.sorted()), id: \.self) { ingredientName in
                    IngredientMiniCardView(selectedIngredientName: $selectedIngredientName, ingredientName: ingredientName)
                }
            }
        }
    }
}


#Preview {
    FavoritesMiniScrollView(selectedIngredientName:  .constant(IdentifiableString(id: "Tequila")))
        .environmentObject(FavoriteDrinksViewModel(service: CocktailService()))
}
