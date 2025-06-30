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
            VStack(spacing: ThemeSpacing.none) {
                      Text("·  The Menu  ·")
                          .font(ThemeFont.drinkTitle)
                      
                      Text("Refine the random.")
                          .font(ThemeFont.listTitle)
                          .opacity(0.8)

                      HStack {
                          
                      VStack(spacing: ThemeSpacing.compact) { //spacing: 4
                             lineDecoration
                             lineDecoration
                         }
                          Image("cocktail")
                              .renderingMode(.template)
                              .resizable()
                              .scaledToFit()
                              .frame(width: ThemeSize.iconSizeMedium, height: ThemeSize.iconSizeMedium)
                      }
                      .padding(.top, -ThemeSpacing.compact)
                  }
            .foregroundColor(.backgroundDark)
                  .padding(.vertical, ThemeSpacing.small)
                  .padding(.horizontal, ThemeSpacing.horizontal)
                  .frame(minHeight: ThemeSpacing.sectionTop)
                  .background(.backgroundLight)
                  .overlay(
                      RoundedRectangle(cornerRadius: ThemeSpacing.none)
                        .stroke(.backgroundDark.opacity(0.7), lineWidth: ThemeSize.borderLineWidth)
                  )
                  .overlay(
                      RoundedRectangle(cornerRadius: ThemeSpacing.none)
                        .stroke(.backgroundDark.opacity(0.7), lineWidth: ThemeSize.borderLineWidthThin)

                          .padding(ThemeSpacing.compact)
                  )
                  .rotationEffect(.degrees(-14))
                  .shadow(radius: ThemeSpacing.shadowRadius)
        }
    }
    
    var lineDecoration: some View {
        Rectangle()
            .frame(height: ThemeSize.borderLineWidth)
            .foregroundColor(.secondary)
            .opacity(0.5)
    }
}

#Preview {
    PeekingMenuCorner()
}
