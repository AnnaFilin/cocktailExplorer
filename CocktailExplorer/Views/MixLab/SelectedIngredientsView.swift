//
//  SelectedIngredientsView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 17/06/2025.
//

import SwiftUI

struct SelectedIngredientsView: View {
    @EnvironmentObject var viewModel: IngredientFilterViewModel
    @Binding var selectedIngredientName: IdentifiableString?
    
    var body: some View {
        if !viewModel.selectedIngredients.isEmpty {
            Text("Selected Ingredients")
                .font(ThemeFont.sectionHeader)
                .foregroundStyle(.backgroundLight.opacity(0.8))
                .padding(.bottom, ThemeSpacing.elementSpacing)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading){
                HStack(alignment: .top, spacing: ThemeSpacing.elementSpacing) {
                    FlowLayout(items: Array(viewModel.selectedIngredients)) { ingredient in
                        IngredientCapsule(selectedIngredientName: $selectedIngredientName, ingredient: ingredient)
                            .environmentObject(viewModel)
                    }
                    
                    Text("Reset All")
                        .foregroundColor(.accentRed)
                        .font(ThemeFont.captionMedium)
                        .padding(.horizontal,ThemeSpacing.elementSpacing)
                        .padding(.vertical,ThemeSpacing.elementSpacing)
                        .background(
                            Capsule()
                                .fill(Color.backgroundLight.opacity(0.1))
                        )
                        .onTapGesture {
                            Task {
                                await viewModel.resetAll()
                            }
                        }
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, ThemeSpacing.elementSpacing)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
}

#Preview {
    SelectedIngredientsView(selectedIngredientName:  .constant(IdentifiableString(id: "Tequila")))
        .environmentObject(IngredientFilterViewModel(service: CocktailService()))
}
