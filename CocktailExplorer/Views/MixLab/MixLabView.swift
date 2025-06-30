//
//  MixLabView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 11/06/2025.
//
// TODO: Show empty state when no ingredients selected
import SwiftUI

struct IdentifiableString: Identifiable {
    let id: String
}

struct MixLabView: View {
    @EnvironmentObject var viewModel: IngredientFilterViewModel
    @EnvironmentObject private var ingredientDetailsViewModel: IngredientDetailsViewModel
    @EnvironmentObject var drinksViewModel: DrinksViewModel
    @Binding var backgroundColor: Color
    @State private var selectedIngredientName: IdentifiableString? = nil
    @State var showInitialBlock = true
    @State private var visibleDrinks = false
    
    var body: some View {
        NavigationStack {
            BaseView(backgroundColor: backgroundColor) {
                SectionHeaderView(title: "By Composition", subtitle: "What lies beneath the flavor.", alignment: .center)
                    .padding(.top, ThemeSpacing.sectionTop)
                
                SearchFieldView(searchText: $viewModel.searchText, isDark: true)
                    .environmentObject(viewModel)
                
                VStack{
                    if viewModel.isLoading || viewModel.ingredients.isEmpty {
                        VStack {
                            ProgressView("Loading ingredients...")
                                .progressViewStyle(CircularProgressViewStyle())
                        }
                        .transition(.opacity)
                        
                    } else if  !viewModel.ingredients.isEmpty {
                        
                        VStack(alignment: .center, spacing: ThemeSpacing.compact) {
                            
                            if showInitialBlock {
                                InitialEmptyView()
                            }
                            
                            else {
                                if !showInitialBlock {
                                  SelectedIngredientsView(selectedIngredientName: $selectedIngredientName)
                                    .padding(.top, ThemeSpacing.elementSpacing)
                                    .transition(.opacity.combined(with: .move(edge: .top)))
                                    .animation(.easeInOut(duration: 0.6), value: showInitialBlock)
                                    .environmentObject(viewModel)
                                }
                                
                                ScrollView {
                                    VStack(spacing: ThemeSpacing.elementSpacing) {
                                        IngredientSuggestionsView(selectedIngredientName: $selectedIngredientName)
                                            .padding(.top, ThemeSpacing.elementSpacing)
                                            .environmentObject(viewModel)
                                        
                                        Divider()
                                            .background(.backgroundLight.opacity(0.15))
                                            .padding(.vertical, ThemeSpacing.compact)
                                        
                                        DrinkListContainerView(
                                            drinks: viewModel.filteredDrinks,
                                            title: viewModel.filteredDrinks.isEmpty ? nil : "Matching Cocktails",
                                            emptyMessage: "No cocktails match your selection.",
                                            isDarkBackground: true,
                                            isLoading: false,
                                            errorMessage: nil,
                                            showEmptyMessage: !viewModel.selectedIngredients.isEmpty
                                        )
                                        .opacity(visibleDrinks ? 1 : 0)
                                        .scaleEffect(visibleDrinks ? 1 : 0.97)
                                        .animation(.easeInOut(duration: 0.7), value: visibleDrinks)
                                        .environmentObject(drinksViewModel)
                                        
                                    }
                                }
                                .animation(.easeInOut(duration: 0.3), value: viewModel.filteredIngredients)
                            }
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, ThemeSpacing.elementSpacing)
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
                withAnimation(.easeInOut(duration: 0.6)) {
                    showInitialBlock = false
                }
            }
        }
        .onChange(of: viewModel.filteredDrinks) {
            withAnimation(.easeInOut(duration: 0.4)) {
                visibleDrinks = !viewModel.filteredDrinks.isEmpty
            }
        }
        
    }
}

#Preview {
    MixLabView(backgroundColor: .constant(.backgroundDark))
        .environmentObject(IngredientFilterViewModel.preview)
        .environmentObject(DrinksViewModel.preview)
        .environmentObject(IngredientDetailsViewModel(service: CocktailService()))
}

