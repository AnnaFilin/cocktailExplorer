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
    
    @State var showCategoryMenu = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        if let randomDrink = drinksViewModel.randomDrink {
                            
                            SectionHeaderView(title: "A Curious Pour", subtitle: nil, alignment: .center)
                            
                            
                            NavigationLink(value: randomDrink.id) {
                                
                                DrinkCardView(drink: randomDrink, showIngredients: false)
                            }
                    
                            
                            Button(action: {
                                Task {
                                    await drinksViewModel.loadRandomDrink()
                                }
                            }) {
                                Text("Mix me another")
                                    .font(.custom("Georgia", size: 24).weight(.semibold))
                                    .foregroundColor(.accentRed)
                                    .padding(.horizontal, 32)
                            }
                            .padding(.vertical, 6)
                            
                            AlcoholFilterSelector(selectedAlcoholFilter: $drinksViewModel.selectedAlcoholFilter)
                            
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
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
           
                
                CategoryMenuToggleView(showCategoryMenu: $showCategoryMenu,  selectedCategory: $drinksViewModel.selectedCategory,
                                       onSelectCategory: {
                                           withAnimation {
                                               showCategoryMenu = false
                                           }
                                       })
                .zIndex(1)
            }
    
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
