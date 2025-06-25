//
//  PeekingMenuCorner.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 21/06/2025.
//

import SwiftUI

struct PeekingMenuCorner: View {
    var body: some View {
        ZStack {
                  VStack(spacing: 4) {
                      Text("·  The Menu  ·")
                          .font(ThemeFont.drinkTitle)
                          .padding(.top, 6)
                      
                      Text("Refine the random.")
                          .font(ThemeFont.listTitle)
                          .opacity(0.8)
                             .padding(.bottom, 2)

                      
                      HStack {
                          
                      VStack(spacing: 4) {
                             lineDecoration
                             lineDecoration
                         }
                          Image("cocktail")
                              .renderingMode(.template)
                              .resizable()
                              .scaledToFit()
                              .frame(width: 40, height: 40)
                              .foregroundColor(.backgroundDark)

                      }

                  }
                  .padding(.horizontal, 20)
                  .padding(.vertical, 8)
                  .background(Color.backgroundLight)
                  .overlay(
                      RoundedRectangle(cornerRadius: 0)
                          .stroke(.backgroundDark.opacity(0.7), lineWidth: 1)
                  )
                  .overlay(
                      RoundedRectangle(cornerRadius: 0)
                          .stroke(.backgroundDark.opacity(0.9), lineWidth: 0.5)
                          .padding(4)
                  )
                  .rotationEffect(.degrees(-14))
                  .shadow(radius: 2)
              }
    }
    
    var lineDecoration: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.secondary)
            .opacity(0.5)
            .padding(.vertical,0)
    }
}

#Preview {
    PeekingMenuCorner()
}
