//
//  DrinkListSectionView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 24/06/2025.
//

import SwiftUI

struct DrinkListSectionView: View {
    let drinks: [Drink]
    let title: String?
    let emptyMessage: String
    var isDarkBackground: Bool = false
    let showEmptyMessage: Bool
    
    var body: some View {
        if drinks.isEmpty  && showEmptyMessage{
            Text(emptyMessage)
                .font(ThemeFont.sectionLabel)
                .foregroundStyle(isDarkBackground ? .backgroundLight.opacity(0.8) : .backgroundDark.opacity(0.8))
                .frame(maxWidth: .infinity, alignment: .center)
        } else {
            VStack(spacing: ThemeSpacing.elementSpacing) {
                if let title = title {
                    Text(title)
                        .font(ThemeFont.sectionHeader)
                        .foregroundStyle(isDarkBackground ? .backgroundLight : .backgroundDark)
                        .opacity(0.8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                ForEach(drinks, id: \.self) { drink in
                    NavigationLink(value: drink.id) {
                        DrinkListItemView(drink: drink, isDarkBackground: isDarkBackground)
                    }
                }
            }
            .padding(.bottom, ThemeSpacing.sectionBottom)

        }
    }
}


#Preview {
    DrinkListSectionView( drinks: [.example, .example],
    title: "Sample Cocktails",
    emptyMessage: "No drinks available",
                          isDarkBackground: false, showEmptyMessage: false)
    .environmentObject(DrinksViewModel.preview)
}
