//
//  DrinksGalleryView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 02/06/2025.
//

import SwiftUI

struct DrinksGalleryView: View {
    @Binding var backgroundColor: Color
    
    @EnvironmentObject var drinksViewModel: DrinksViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                VStack{
                    
                    DrinkOfTheDayBannerView()
                        .padding(.top, ThemeSpacing.sectionTop)
                    
                    SearchFieldView(
                        searchText: $drinksViewModel.searchText,
                        onToggleFavorites: {
                            drinksViewModel.showOnlyFavorites.toggle()
                        }, isDark: false
                    )
                    .padding(.horizontal)
                    
                    DrinkListContainerView(
                        drinks: drinksViewModel.filteredDrinks,
                        title: nil,
                        emptyMessage: "No drinks found",
                        isDarkBackground: false,
                        isLoading: drinksViewModel.isLoading,
                        errorMessage: drinksViewModel.allDrinksErrorMessage
                    )
                    .environmentObject(drinksViewModel)
                    .padding(.horizontal)
                }
                
                
            }
            .navigationDestination(for: String.self) { id in
                DrinkDetailView(drinkId: id, backgroundColor: $backgroundColor)
                    .environmentObject(drinksViewModel)
            }
        }
        .onChange(of: drinksViewModel.currentDrink) {
            
            if drinksViewModel.currentDrink == nil {
                withAnimation(.easeInOut(duration: 0.6)) {
                    backgroundColor = .backgroundLight
                }
            }
        }
        
        .onAppear {
            if backgroundColor != .backgroundLight {
                withAnimation(.easeInOut(duration: 1.7)) {
                    backgroundColor = .backgroundLight
                }
            }
        }
    }
}

#Preview {
    DrinksGalleryView(backgroundColor: .constant(.backgroundLight))
        .environmentObject(DrinksViewModel.preview)
}
