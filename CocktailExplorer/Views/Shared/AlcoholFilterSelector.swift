//
//  AlcoholFilterSelector.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 22/06/2025.
//

import SwiftUI

enum AlcoholFilterOption: String, CaseIterable, Equatable {
    case alcoholic
    case nonAlcoholic
    case optionalAlcohol

    var title: String {
        switch self {
        case .alcoholic: return "Boozy"
        case .nonAlcoholic: return "Virgin"
        case .optionalAlcohol: return "Flex"
        }
    }

    var filterKey: String {
        switch self {
        case .alcoholic: return "Alcoholic"
        case .nonAlcoholic: return "Non alcoholic"
        case .optionalAlcohol: return "Optional alcohol"
        }
    }
}


    
    struct AlcoholFilterSelector: View {
        @Binding var selectedAlcoholFilter: AlcoholFilterOption?

        var body: some View {
            let options = AlcoholFilterOption.allCases

            HStack(spacing: ThemeSpacing.small) { 
                ForEach(options, id: \.self) { option in
                    let isSelected = selectedAlcoholFilter == option
                    let textColor: Color = isSelected ? .backgroundDark : .backgroundLight
                    let fillColor: Color = isSelected ? .backgroundLight : .clear
                    let shadowColor: Color = isSelected ? .black.opacity(0.05) : .clear
                    let borderWidth: CGFloat = isSelected ? 0 : 0.5

                    Text(option.title)
                        .font(ThemeFont.pillButton)
                        .foregroundColor(textColor)
                        .padding(.vertical, ThemeSpacing.small)
                        .padding(.horizontal, ThemeSpacing.medium)
                        .background(
                            Capsule()
                              .fill(fillColor)
                              .shadow(color: shadowColor, radius: 1, x: 0, y: 1)
                          )
                          .overlay(
                            Capsule()
                              .stroke(.backgroundLight.opacity(0.2), lineWidth: borderWidth)
                          )

                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedAlcoholFilter = option
                            }
                        }
                }
            }
            .padding(.top, ThemeSpacing.medium) 
        }
    }


#Preview {
    AlcoholFilterSelector(selectedAlcoholFilter: .constant(.alcoholic))
}
