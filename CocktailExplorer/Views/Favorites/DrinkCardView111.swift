//
//  DrinkCardView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 18/06/2025.
//

import SwiftUI

struct DrinkCardView111: View {
    let drink: DrinkDetail
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: drink.thumbnail)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .cornerRadius(10)
                }
            }
  
            Text(drink.name)
                .font(ThemeFont.listTitle)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .frame(width: 110, height: 40)
                .padding(.horizontal, 4)       
        }
        .frame(width: 120, height: 160)
        .background(.ultraThinMaterial.opacity(0.1))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

//#Preview {
//    DrinkCardView(drink: .example)
//}
