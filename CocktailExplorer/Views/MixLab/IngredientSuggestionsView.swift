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
            VStack(alignment: .leading, spacing: ThemeSpacing.elementSpacing) {
                Text("Suggestions")
                    .font(ThemeFont.sectionHeader)
                    .foregroundStyle(.backgroundLight.opacity(0.8))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, ThemeSpacing.elementSpacing)
                
                ScrollView(.vertical, showsIndicators: true)  {
                    FlowLayout(items: viewModel.filteredIngredients, spacing: ThemeSpacing.compact) { ingredient in
                        IngredientCapsule(selectedIngredientName: $selectedIngredientName, ingredient: ingredient)
                            .environmentObject(viewModel)
                    }
                    .padding(.bottom, ThemeSpacing.elementSpacing)
                }
                .frame(maxHeight: ThemeSize.suggestionsMaxHeight)
                .mask(
                  LinearGradient(
                    gradient: Gradient(stops: [
                      .init(color: .white, location: 0.0),
                      .init(color: .white, location: 0.85),
                      .init(color: .clear, location: 1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                  )
                )

            }
        }
    }
}

#Preview {
    IngredientSuggestionsView(selectedIngredientName:  .constant(IdentifiableString(id: "Tequila")))
        .environmentObject(IngredientFilterViewModel(service: CocktailService()))
}
