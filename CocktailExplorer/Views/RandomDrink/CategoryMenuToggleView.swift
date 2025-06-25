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
                    .padding(.bottom, 16)
                } else {
                    PeekingMenuCorner()
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                showCategoryMenu = true
                            }
                        }
                        .padding(.bottom, 12)
                        .opacity(0.9)
                        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: -1)
                        .offset(y: 28)
                }
            }
        }
    }
}

#Preview {
    CategoryMenuToggleView(showCategoryMenu: .constant(true), selectedCategory: .constant("Cocktail"), onSelectCategory: {})
}
