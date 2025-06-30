//
//  DrinkListItemView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 09/06/2025.
//

import SwiftUI

struct DrinkListItemView: View {
    let drink: Drink
    var isDarkBackground: Bool = false
    
    var body: some View {
        HStack(alignment: .center, spacing: ThemeSpacing.elementSpacing){
            AsyncImage(url: URL(string: drink.thumbnail)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: ThemeSize.drinkImageSize, height: ThemeSize.drinkImageSize)
                        .clipShape(RoundedRectangle(cornerRadius: ThemeSpacing.cornerRadiusSmall))
                } else {
                    Color.gray
                        .frame(width: ThemeSize.drinkImageSize, height: ThemeSize.drinkImageSize)
                        .clipShape(RoundedRectangle(cornerRadius: ThemeSpacing.cornerRadiusSmall))
                }
            }
            
            VStack(alignment: .leading) {
                Text(drink.name)
                    .font(ThemeFont.body)
                    .opacity(0.9)
                    .foregroundStyle(isDarkBackground ? .backgroundLight : .backgroundDark)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
            }
            
            Spacer()
            
            FavoritesButtonView(drinkId: drink.id)
                .font(ThemeFont.favoriteIcon)
                .foregroundStyle(isDarkBackground ? .backgroundLight.opacity(0.7) : .backgroundDark.opacity(0.7))
                .padding(.trailing, ThemeSpacing.small)
        }
        .padding(.vertical, ThemeSpacing.compact)
        
    }
}

#Preview {
    DrinkListItemView(drink: Drink.example)
        .environmentObject(DrinksViewModel.preview)
    
}
