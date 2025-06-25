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
        HStack(alignment: .center){
            AsyncImage(url: URL(string: drink.thumbnail)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.trailing, 12)
                }
            }
            .frame(width: 70, height: 70)
            
            VStack(alignment: .leading) {
                
                Text(drink.name)
                    .font(ThemeFont.listTitle)
                    .foregroundStyle(isDarkBackground ? .backgroundLight : .backgroundDark)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
            }
            
            Spacer()
            
            
            FavoritesButtonView(drinkId: drink.id)
                .font(.system(size: 18))
                .foregroundStyle(isDarkBackground ? .backgroundLight : .backgroundDark.opacity(0.7))
        }
        .frame(maxHeight: .infinity, alignment: .center)
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}

#Preview {
    DrinkListItemView(drink: Drink.example)
        .environmentObject(DrinksViewModel.preview)

}
