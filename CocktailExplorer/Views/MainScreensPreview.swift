//
//  MainScreensPreview.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 24/06/2025.
//

import Foundation
import SwiftUI

#Preview("Main Screens Side-by-Side") {
    ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 0) {
            DrinksGalleryView(backgroundColor: .constant(.backgroundLight))
                .frame(width: 430, height: 932) // iPhone 16 Pro
                .environmentObject(DrinksViewModel.preview)

            MixLabView(backgroundColor: .constant(.backgroundDark))
                .frame(width: 430, height: 932)
                .environmentObject(DrinksViewModel.preview)
                .environmentObject(IngredientFilterViewModel())
                .environmentObject(IngredientDetailsViewModel())

            RandomDrinkView(backgroundColor: .constant(.backgroundDark))
                .frame(width: 430, height: 932)
                .environmentObject(DrinksViewModel.preview)
                .environmentObject(IngredientFilterViewModel())

            FavoritesView(backgroundColor: .constant(.backgroundDark))
                .frame(width: 430, height: 932)
                .environmentObject(DrinksViewModel.preview)
                .environmentObject(FavoriteDrinksViewModel())
        }
    }
}
