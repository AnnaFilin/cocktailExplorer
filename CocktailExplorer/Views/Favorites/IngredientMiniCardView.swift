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

        VStack(spacing: ThemeSpacing.small) { //spacing: 4
            AsyncImage(url: URL(string: baseUrl + ingredientName + "-Medium.png")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
  
            Text(ingredientName)
                .font(ThemeFont.smallRegular)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.7)
                .foregroundStyle(.backgroundLight.opacity(0.95))
        }
        .padding(.top, ThemeSpacing.small)
        .padding(.bottom, ThemeSpacing.small)
        .padding(.horizontal, ThemeSpacing.small)
        .frame(width: ThemeSize.ingredientCardWidth, height: ThemeSize.ingredientCardHeight)

        .background(.ultraThinMaterial.opacity(0.1))
        .cornerRadius(ThemeSpacing.cornerRadiusSmall)
        .overlay(
            RoundedRectangle(cornerRadius:ThemeSpacing.cornerRadiusSmall)
                .stroke(isSelected ? Color.accentRed : Color.white.opacity(0.08), lineWidth: 1)
        )
        .shadow(radius: ThemeSpacing.shadowRadius)
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
    .environmentObject(FavoriteDrinksViewModel(service: CocktailService()))
}
