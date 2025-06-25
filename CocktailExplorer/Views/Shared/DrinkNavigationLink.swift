//
//  DrinkNavigationLink.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 24/06/2025.
//

import SwiftUI

struct DrinkNavigationLink<Content: View>: View {
    let drinkId: String
    let content: () -> Content

    var body: some View {
        NavigationLink(value: drinkId) {
            content()
        }
    }
}

