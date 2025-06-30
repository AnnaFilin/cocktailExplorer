//
//  DrinkListContainerView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 24/06/2025.
//

import SwiftUI

struct DrinkListContainerView: View {
    let drinks: [Drink]
    let title: String?
    let emptyMessage: String
    let isDarkBackground: Bool
    let isLoading: Bool
    let errorMessage: String?
    let showEmptyMessage: Bool
    
    var body: some View {
        if isLoading {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let errorMessage = errorMessage {
            Text(errorMessage)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ScrollView {
                DrinkListSectionView(
                    drinks: drinks,
                    title: title,
                    emptyMessage: emptyMessage,
                    isDarkBackground: isDarkBackground,
                    showEmptyMessage: showEmptyMessage
                )
            }
        }
    }
}


#Preview {
    DrinkListContainerView( drinks: [.example, .example],
    title: "Sample Drinks",
    emptyMessage: "No drinks found",
    isDarkBackground: false,
    isLoading: false,
                            errorMessage: nil, showEmptyMessage: false)
    .environmentObject(DrinksViewModel.preview)
}
