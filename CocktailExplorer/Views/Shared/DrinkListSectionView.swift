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
    
    var body: some View {
        if drinks.isEmpty {
            Text(emptyMessage)
                .font(ThemeFont.sectionLabel)
                .foregroundStyle(isDarkBackground ? .backgroundLight.opacity(0.8) : .backgroundDark.opacity(0.8))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 20)
        } else {
            VStack(spacing: 12) {
                if let title = title {
                    Text(title)
                        .font(ThemeFont.sectionLabel)
                        .foregroundStyle(isDarkBackground ? .backgroundLight : .backgroundDark)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, ThemeSpacing.horizontal)
                }

                ForEach(drinks, id: \.self) { drink in
                    NavigationLink(value: drink.id) {
                        DrinkListItemView(drink: drink, isDarkBackground: isDarkBackground)
                    }
                }
            }
            .padding(.bottom, 32)
        }
    }
}


#Preview {
    DrinkListSectionView( drinks: [.example, .example],
    title: "Sample Cocktails",
    emptyMessage: "No drinks available",
    isDarkBackground: false)
}
