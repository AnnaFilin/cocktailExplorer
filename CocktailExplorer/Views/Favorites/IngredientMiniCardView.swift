//
//  IngredientMiniCardView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 20/06/2025.
//

import SwiftUI

struct IngredientMiniCardView: View {
    @EnvironmentObject var favoritsViewModel: FavoriteDrinksViewModel
    @Binding var selectedIngredientName: IdentifiableString?
    let ingredientName: String
    let baseUrl = "https://www.thecocktaildb.com/images/ingredients/"
    
    var body: some View {
        let isSelected = favoritsViewModel.selectedIngredient == ingredientName

        VStack(spacing: 4) {
            AsyncImage(url: URL(string: baseUrl + ingredientName + "-Medium.png")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 70)
                        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                        .cornerRadius(6)
                }
            }
  
            Text(ingredientName)
                .font(ThemeFont.listSubtitle)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.7)
                .frame(width: 90, height: 34)
                .padding(.horizontal, 4)
                .foregroundStyle(.backgroundLight.opacity(0.95))
                .cornerRadius(12)
        }
        .padding(.top, 6)
        .frame(width: 100, height: 120)
        .background(.ultraThinMaterial.opacity(0.1))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.accentRed : Color.white.opacity(0.08), lineWidth: 1)
        )
        .shadow(radius: 4)
        .onTapGesture {
            if favoritsViewModel.selectedIngredient == ingredientName {
                favoritsViewModel.selectedIngredient = nil
            } else {
                favoritsViewModel.selectedIngredient = ingredientName
            }
        }
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.6)
                .onEnded { _ in
                    selectedIngredientName = IdentifiableString(id: ingredientName)
                }
        )

    }
}

#Preview {
    IngredientMiniCardView(
        selectedIngredientName: .constant(IdentifiableString(id: "Tequila")),
        ingredientName: "Southern Comfort"
    )
    .environmentObject(FavoriteDrinksViewModel())
}
