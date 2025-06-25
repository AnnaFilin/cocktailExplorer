//
//  FavoritesView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 18/06/2025.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var drinksViewModel: DrinksViewModel
    @EnvironmentObject var favoritsViewModel: FavoriteDrinksViewModel
    @EnvironmentObject var ingredientDetailsViewModel: IngredientDetailsViewModel
    
    @Binding var backgroundColor: Color
    @State private var selectedIngredientName: IdentifiableString? = nil
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 6) {
                       
                        VStack {
                            SectionHeaderView(title: "Favorites", subtitle: "The drinks you loved the most.", alignment: .center)
                        }
                        .padding(.top, ThemeSpacing.sectionTop)

                        
                        if favoritsViewModel.favoriteDrinks.isEmpty {
                            Text("You haven't added any favorites yet.")
                                .padding()
                            
                        } else {
                            FavoritesCarouselView()
                                .environmentObject(favoritsViewModel)
                            
                            Text("Ingredients you use the most.")
                                .font(ThemeFont.sectionLabel)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.backgroundLight.opacity(0.8))
                                .padding(.vertical, 6)
                                .padding(.horizontal, ThemeSpacing.horizontal)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            FavoritesMiniScrollView(selectedIngredientName: $selectedIngredientName)
                                .environmentObject(favoritsViewModel)
                        }
                    }
                    .padding(.top, 10)
                    .foregroundStyle(.backgroundLight)
                    
                }
            }
            .navigationDestination(for: String.self) { id in
                DrinkDetailView(drinkId: id, backgroundColor: $backgroundColor)
                    .environmentObject(drinksViewModel)
            }
            .sheet(item: $selectedIngredientName) { wrapper in
                IngredientDetailSheet(ingredientName: wrapper.id)
                    .environmentObject(ingredientDetailsViewModel)
            }
        }
        .onAppear() {
            withAnimation(.easeInOut(duration: 1.5)) {
                backgroundColor = .backgroundDark
            }
            Task {
                  await favoritsViewModel.initializeFromIDs(drinksViewModel.favoriteDrinkIDs)
              }
        }
    }
}

#Preview {
    let previewDrinksVM = DrinksViewModel.preview
       let previewFavoritesVM = FavoriteDrinksViewModel()

    FavoritesView(
           backgroundColor: .constant(.backgroundDark)
       )
       .environmentObject(previewDrinksVM)
       .environmentObject(previewFavoritesVM)
       .environmentObject(IngredientDetailsViewModel())
}
