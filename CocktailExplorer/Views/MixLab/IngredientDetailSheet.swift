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
                .shadow(color: .black.opacity(0.1), radius: ThemeSpacing.shadowRadius, y: 2)
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
                                .frame(
                                    width: ThemeSize.ingredientSheetImageWidth,
                                    height: ThemeSize.ingredientSheetImageHeight
                                )
                                .clipped()
                                .cornerRadius(ThemeSpacing.cornerRadiusSmall)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        VStack(alignment: .leading, spacing: ThemeSpacing.compact) {
                            Text(ingredient.strIngredient)
                                .font(ThemeFont.drinkTitle)
                                .opacity(0.87)
                            
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
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                        .padding(.vertical, ThemeSpacing.elementSpacing)
                    
                    ScrollView {
                        if let description = ingredientDetailsViewModel.selectedIngredient?.strDescription {
                            Text("About \(ingredientName)")
                                .font(ThemeFont.listTitle)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, ThemeSpacing.compact)
                            
                            Text(description)
                                .font(ThemeFont.sectionLabel)
                                .opacity(0.9)
                            
                        } else {
                            EmptyIngredientDescription(ingredientName: ingredient.strIngredient)
                        }
                    }
                }
                .padding(.all, ThemeSpacing.horizontal)
                .padding(.bottom, ThemeSpacing.sectionBottom)
                .foregroundStyle(.backgroundDark)
            }
        }
        .overlay(
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.black.opacity(0.08), .clear]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: ThemeSpacing.large),
            alignment: .top
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
        .environmentObject(IngredientDetailsViewModel(service: CocktailService()))
}
