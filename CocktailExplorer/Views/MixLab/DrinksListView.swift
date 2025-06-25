//
//  DrinksListView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 17/06/2025.
//

import SwiftUI

struct DrinksListView: View {
    @EnvironmentObject var viewModel: IngredientFilterViewModel

    var body: some View {
        ScrollView {
            if viewModel.filteredDrinks.isEmpty {
                Text("No cocktails match your selection.")
                    .font(ThemeFont.sectionLabel)
                    .foregroundStyle(.backgroundLight.opacity(0.8))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)
            } else {
                VStack(spacing: 12) {
                    Text("Matching Cocktails")
                        .font(ThemeFont.sectionLabel)
                        .foregroundStyle(.backgroundLight)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, ThemeSpacing.horizontal)

                    
                    ForEach(viewModel.filteredDrinks, id: \.self) { drink in
                        NavigationLink(value: drink.id) {
                            DrinkListItemView(drink: drink, isDarkBackground: true)
                        }
                    }
                }
                .padding(.bottom, 32)
            }
        }
    }
}

#Preview {
    DrinksListView()
        .environmentObject(IngredientFilterViewModel())
        .environmentObject(DrinksViewModel.preview)
}
