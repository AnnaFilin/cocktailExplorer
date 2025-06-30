//
//  RandomDrinkView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 04/06/2025.
//

import SwiftUI


struct RandomDrinkView: View {
    @Binding var backgroundColor: Color
    
    @EnvironmentObject var drinksViewModel: DrinksViewModel
    @State private var isVisible = true
    @State var showCategoryMenu = false
    
    var body: some View {
        NavigationStack {
            BaseView(backgroundColor: backgroundColor) {
                SectionHeaderView(title: "A Curious Pour", subtitle: nil, alignment: .center)
                    .padding(.top, ThemeSpacing.sectionTop)
                
                ScrollView {
                    VStack(spacing: ThemeSpacing.elementSpacing)  {
                        if let randomDrink = drinksViewModel.randomDrink {
                            NavigationLink(value: randomDrink.id) {
                                DrinkCardView(
                                    drink: randomDrink,width: ThemeSize.drinkCardWidth,
                                    height: ThemeSize.drinkCardHeight,
                                    showIngredients: false
                                )
                                .opacity(isVisible ? 1 : 0)
                                .scaleEffect(isVisible ? 1 : 0.98)
                                .animation(.easeInOut(duration: 0.8), value: isVisible)
                            }
                            
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.8)) {
                                    drinksViewModel.randomDrink = nil
                                    isVisible = false
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                    Task {
                                        await drinksViewModel.loadRandomDrink()
                                        withAnimation(.easeInOut(duration: 0.8)) {
                                            isVisible = true
                                        }
                                    }
                                }
                            }) {
                                Text("Mix me another")
                                    .font(ThemeFont.actionButton)
                                    .foregroundColor(.backgroundLight)
                                    .padding(.vertical, ThemeSpacing.medium)
                                    .padding(.horizontal, ThemeSpacing.large)
                                    .background(
                                        RoundedRectangle(cornerRadius: ThemeSpacing.cornerRadiusSmall)
                                            .fill(.accentRed.opacity(0.9))
                                    )
                            }
                            .padding(.horizontal, ThemeSpacing.large)
                            .padding(.top, ThemeSpacing.medium)
                            //                            AlcoholFilterSelector(selectedAlcoholFilter: $drinksViewModel.selectedAlcoholFilter)
                            //                                .padding(.top, ThemeSpacing.small)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, ThemeSpacing.sectionBottom)
                }
                .foregroundStyle(.backgroundLight)
                .scrollContentBackground(.hidden)
                .onAppear() {
                    Task {
                        if drinksViewModel.randomDrink == nil {
                            
                            await drinksViewModel.loadRandomDrink()
                        }
                    }
                }
            }
            .overlay(
                CategoryMenuToggleView(
                    showCategoryMenu: $showCategoryMenu,
                    selectedCategory: $drinksViewModel.selectedCategory,
                    onSelectCategory: {
                        withAnimation {
                            showCategoryMenu = false
                        }
                    })
                .frame(maxWidth: .infinity)
                .zIndex(100)
            )
            .navigationDestination(for: String.self) { id in
                DrinkDetailView(drinkId: id, backgroundColor: $backgroundColor)
                    .environmentObject(drinksViewModel)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.7)) {
                backgroundColor = .backgroundDark
            }
        }
    }
}

#Preview {
    RandomDrinkView(backgroundColor: .constant(.backgroundDark))
        .environmentObject(DrinksViewModel.preview)
}
