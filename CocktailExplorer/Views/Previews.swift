//
//  Previews.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 23/06/2025.
//

import Foundation

import SwiftUI

import SwiftUI

#Preview("Gallery Screen") {
    DrinksGalleryView(backgroundColor: .constant(.backgroundLight))
        .environmentObject(DrinksViewModel.preview)
//        .previewDevice("iPhone 15 Pro")
}

#Preview("Mix Lab Screen") {
    MixLabView(backgroundColor: .constant(.backgroundDark))
        .environmentObject(DrinksViewModel.preview)
        .environmentObject(IngredientFilterViewModel())
        .environmentObject(IngredientDetailsViewModel())
//        .previewDevice("iPhone 15 Pro")
}
