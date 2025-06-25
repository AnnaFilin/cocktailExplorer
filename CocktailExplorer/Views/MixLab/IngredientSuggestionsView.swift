//
//  IngredientSuggestionsView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 17/06/2025.
//

import SwiftUI

struct IngredientSuggestionsView: View {
    @EnvironmentObject var viewModel: IngredientFilterViewModel
    @Binding var selectedIngredientName: IdentifiableString?

    var body: some View {
        if !viewModel.filteredIngredients.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Text("Suggestions")
                    .font(ThemeFont.sectionLabel)
                    .foregroundStyle(.backgroundLight)
                    .padding(.top, ThemeSpacing.elementSpacing)
                    .padding(.bottom, ThemeSpacing.elementSpacing)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, ThemeSpacing.horizontal)
                
                ScrollView(.vertical, showsIndicators: true)  {
                    FlowLayout(items: viewModel.filteredIngredients) { ingredient in
                        IngredientCapsule(selectedIngredientName: $selectedIngredientName, ingredient: ingredient)
                            .environmentObject(viewModel)
                    }
                    .padding(.horizontal, ThemeSpacing.horizontal/2)
                    .padding(.bottom, ThemeSpacing.elementSpacing)
                }
                .frame(maxHeight: 140)
            }
        }
    }
}

#Preview {
    IngredientSuggestionsView(selectedIngredientName:  .constant(IdentifiableString(id: "Tequila")))
        .environmentObject(IngredientFilterViewModel())
}
