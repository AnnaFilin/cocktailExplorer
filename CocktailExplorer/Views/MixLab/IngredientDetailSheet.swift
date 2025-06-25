//
//  IngredientDetailSheet.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 19/06/2025.
//

import SwiftUI

struct IngredientDetailSheet: View {
    @EnvironmentObject var ingredientDetailsViewModel: IngredientDetailsViewModel
    
    let ingredientName: String
    
    var body: some View {
        ZStack {
            Color.backgroundLight
                .shadow(color: .black.opacity(0.1), radius: 5, y: 2)
                .ignoresSafeArea()
            
            if let ingredient = ingredientDetailsViewModel.selectedIngredient {
                VStack(alignment: .leading, spacing: ThemeSpacing.elementSpacing) {
      
                    
                    HStack(alignment: .bottom) {
                        
                   
                        AsyncImage(
                            url: URL(string: "https://www.thecocktaildb.com/images/ingredients/\(ingredientName)-Medium.png")
                        ) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                           .frame(width: 100, height: 200)
                                           .clipped()
                                .cornerRadius(12)
                        } placeholder: {
                            ProgressView()
                        }

                        .padding(.top)

                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(ingredient.strIngredient)
                                .font(ThemeFont.drinkTitle)
                                .opacity(0.87)
                                .padding(.bottom)
                            
                            Group {
                                
                                Text("Type: \(ingredient.strType ?? "—")")
                                Text("Alcohol: \(ingredient.strAlcohol ?? "—")")
                                if let abv = ingredient.strABV {
                                    Text("ABV: \(abv)%")
                                }
                            }
                            .font(ThemeFont.listTitle)
                            .opacity(0.8)
                        }
                        .padding(.leading, 32)
                        .padding(.bottom, 8)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                        .padding(.vertical, 8)

                   
                ScrollView {
                    if let description = ingredientDetailsViewModel.selectedIngredient?.strDescription {
                        Text("About \(ingredientName)")
                            .font(ThemeFont.listTitle)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 8)
                        
                        Text(description)
                            .font(ThemeFont.sectionLabel)
                            .opacity(0.9)
                        
                    } else {
                        EmptyIngredientDescription(ingredientName: ingredient.strIngredient)
                    }
                }
                }

                .padding()
                .padding(.bottom, ThemeSpacing.sectionBottom)
                .cornerRadius(24)
                .foregroundStyle(.backgroundDark)
            }
        }
        .overlay(
            VStack {
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.black.opacity(0.08), .clear]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: 10)
                Spacer()
            }
        )

        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear() {
            Task {
                await ingredientDetailsViewModel.loadIngredientDetails(ingredientName)
            }
        }
    }
}

#Preview {
    IngredientDetailSheet( ingredientName: "Tequila")
        .environmentObject(IngredientDetailsViewModel())
}
