//
//  CategoryMenuToggleView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 24/06/2025.
//

import SwiftUI

struct CategoryMenuToggleView: View {
    
    @Binding var showCategoryMenu: Bool
    @Binding var selectedCategory: String?
    var onSelectCategory: () -> Void
    
    var body: some View {
        Group {
            VStack {
                Spacer()
                if showCategoryMenu {
                    CategoryMenuView(selectedCategory: $selectedCategory,  onSelect: {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                            showCategoryMenu = false
                        }
                    })
                    .onTapGesture {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                            showCategoryMenu = false
                        }
                    }
                    .transition(.move(edge: .bottom))
                    .offset(y: -ThemeSpacing.medium)
                    .padding(.bottom, ThemeSpacing.large)
                } else {
                    PeekingMenuCorner()
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                showCategoryMenu = true
                            }
                        }
                        .padding(.bottom, ThemeSpacing.medium)

                        .opacity(0.9)
                        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: -1)
                        .offset(y: ThemeSpacing.outerPadding)
                }
            }
        }
    }
}

#Preview {
    CategoryMenuToggleView(showCategoryMenu: .constant(true), selectedCategory: .constant("Cocktail"), onSelectCategory: {})
}
