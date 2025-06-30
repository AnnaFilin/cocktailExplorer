//
//  DrinkLargeCardView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 19/06/2025.
//

import SwiftUI

struct DrinkLargeCardView: View {
    
    let drink: DrinkDetail
    
    var body: some View {
        VStack(alignment: .center) { //, spacing: ThemeSpacing.elementSpacing
            Text(drink.name)
                .font(ThemeFont.drinkTitle)
                  .multilineTextAlignment(.center)
                  .lineLimit(2)
                  .minimumScaleFactor(0.6)
//                  .padding(.horizontal, 8)
            
            AsyncImage(url: URL(string: drink.thumbnail)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 300, height: 300)
//                            .clipped()
//                            .cornerRadius(12)
                }
            }
  
            VStack() { //spacing: 8
              
                Text("\(drink.category) · \(drink.alcoholic) · \(drink.glass)")
                    .font(ThemeFont.listSubtitle)
               
                    .multilineTextAlignment(.center)
//                    .padding(.horizontal, 8)

                    Text(
                        drink.ingredients
                            .prefix(4)
                            .map { $0.name }
                            .joined(separator: " · ")
                    )
                    .font(ThemeFont.listSubtitle.weight(.medium))
                    .foregroundStyle(.accentRed)
                    .multilineTextAlignment(.center)
//                    .padding(.horizontal, 8)
                
            }

        }
//        .frame(width: 320, height: 420)
//        .padding()
        .background(.ultraThinMaterial.opacity(0.2))
//        .cornerRadius(20)
//        .shadow(radius: 6)
        
    }
}

#Preview {
    DrinkLargeCardView(drink:  .example)
}
