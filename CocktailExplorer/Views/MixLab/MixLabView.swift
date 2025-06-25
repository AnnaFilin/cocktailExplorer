//
//  MixLabView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 11/06/2025.
//

import SwiftUI

struct IdentifiableString: Identifiable {
    let id: String
}


struct MixLabView: View {
    @StateObject private var viewModel = IngredientFilterViewModel()
    @EnvironmentObject private var ingredientDetailsViewModel: IngredientDetailsViewModel
    @EnvironmentObject var drinksViewModel: DrinksViewModel
    @Binding var backgroundColor: Color
    @State private var selectedIngredientName: IdentifiableString? = nil
    @State var showInitialBlock = true
//    @State var animatedIn = false
   
    var body: some View {
        NavigationStack {
            
            
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                VStack{
                    if viewModel.isLoading || viewModel.ingredients.isEmpty {
                        VStack {
                            Spacer()
                            ProgressView("Loading ingredients...")
                                .progressViewStyle(CircularProgressViewStyle())
                            Spacer()
                        }
                        .transition(.opacity)
                        
                    } else if  !viewModel.ingredients.isEmpty {
                        
                        VStack(alignment: .center, spacing: 4) {
                            MixLabHeaderView()
                                .environmentObject(viewModel)
                         
                            if showInitialBlock {
                                InitialEmptyView()
                            }
                            
                            else {
                                SelectedIngredientsView(selectedIngredientName: $selectedIngredientName)
                                    .transition(.opacity.combined(with: .move(edge: .top)))
                                    .environmentObject(viewModel)
                                
                                ScrollView {
                                    VStack(spacing: 12) {
                                        IngredientSuggestionsView(selectedIngredientName: $selectedIngredientName)
                                            .environmentObject(viewModel)
                                        
                                        Divider()
                                            .background(.backgroundLight.opacity(0.15))
                                            .padding(.vertical, ThemeSpacing.compactSpacing)
                                        
                                        DrinkListContainerView(
                                            drinks: viewModel.filteredDrinks,
                                            title: "Matching Cocktails",
                                            emptyMessage: "No cocktails match your selection.",
                                            isDarkBackground: true,
                                            isLoading: false,
                                            errorMessage: nil
                                        )
                                        .environmentObject(drinksViewModel)

                                    }
                                }
                                .animation(.easeInOut(duration: 0.3), value: viewModel.filteredIngredients)
                            }
                            
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.horizontal, 16)
                    }
                }
            }
            .sheet(item: $selectedIngredientName) { wrapper in
                IngredientDetailSheet(ingredientName: wrapper.id)
                    .environmentObject(ingredientDetailsViewModel)
            }
            .foregroundStyle(.backgroundLight)
            .frame(maxHeight: .infinity)
            .navigationDestination(for: String.self) { id in
                DrinkDetailView(drinkId: id, backgroundColor: $backgroundColor)
                    .environmentObject(drinksViewModel)
            }
        }
        .onAppear() {
            withAnimation(.easeInOut(duration: 1.5)) {
                backgroundColor = .backgroundDark
            }
            
            Task {
                await viewModel.loadIngredients()
            }
        }
        .onChange(of: viewModel.filteredIngredients) {
            if !viewModel.filteredIngredients.isEmpty {
                   withAnimation {
                       showInitialBlock = false
                   }
               }
        }
    }
}

#Preview {
    MixLabView(backgroundColor: .constant(.backgroundDark))
        .environmentObject(IngredientFilterViewModel())
        .environmentObject(DrinksViewModel.preview)
}
