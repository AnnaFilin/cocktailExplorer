//
//  IngredientCapsule.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 11/06/2025.
//

import SwiftUI

struct IngredientCapsule: View {
    @EnvironmentObject var ingredientViewModel: IngredientFilterViewModel
//    @EnvironmentObject var ingredientDetailsViewModel: IngredientDetailsViewModel
    @Binding var selectedIngredientName: IdentifiableString?

    let ingredient: BasicIngredient
    
    var backgroundColor: Color {
        return ingredientViewModel.selectedIngredients.contains(ingredient) ? .accentRed : .clear
    }
    
    var textColor: Color {
        return ingredientViewModel.selectedIngredients.contains(ingredient) ? .white : Color.gray.opacity(0.8)
    }
    
    var borderColor: Color {
        return ingredientViewModel.selectedIngredients.contains(ingredient) ? Color.white.opacity(0.3) : .accentRed
    }
    
    var isSelected: Bool {
        return ingredientViewModel.selectedIngredients.contains(ingredient)
    }
    
    var body: some View {
        ZStack {
            Button(action: {
                Task {
                    
                    await ingredientViewModel.toggleIngredient(ingredient)
                }
                
            }, label: {
                Text(ingredient.name)
                    .font(ThemeFont.listSubtitle)
                    .fontWeight(.medium)
                    .padding(.horizontal,ThemeSpacing.elementSpacing)
                    .padding(.vertical,ThemeSpacing.elementSpacing)
                    .background(backgroundColor)
                    .foregroundColor(textColor)
                    .lineLimit(1)
                    .minimumScaleFactor(1.08)
                    .overlay(
                        Capsule()
                            .strokeBorder(borderColor, lineWidth: isSelected ? 0 : 1.5)
                    )
                    .clipShape(Capsule())
                    .scaleEffect(isSelected ? 1.05 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: isSelected)
            })
        }

        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.6)
                .onEnded { _ in
                    selectedIngredientName = IdentifiableString(id: ingredient.name)
                }
        )

    }
}

#Preview {
    IngredientCapsule(selectedIngredientName:  .constant(IdentifiableString(id: "Tequila")), ingredient: .example)
        .environmentObject(IngredientFilterViewModel())
//        .environmentObject(IngredientDetailsViewModel())
}
