//
//  DrinkLargeCardView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 24/06/2025.
//
import SwiftUI

struct DrinkCardView: View {
    let drink: DrinkDetail
    var width: CGFloat = 300
    var height: CGFloat = 300
    var showGlass: Bool = true
    var showIngredients: Bool = true
    var alignment: HorizontalAlignment = .center
    var font: Font = ThemeFont.drinkTitle

    var body: some View {
        VStack(alignment: alignment, spacing: ThemeSpacing.elementSpacing) {
            Text(drink.name)
                .font(font)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.6)
                .padding(.horizontal, 8)

            AsyncImage(url: URL(string: drink.thumbnail)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width, height: height)
                        .clipped()
                        .cornerRadius(12)
                } else {
                    Image(systemName: "photo")
                }
            }

            VStack(spacing: 8) {
                Text(glassLine)
                    .font(ThemeFont.listSubtitle)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 8)

                if showIngredients {
                    Text(
                        drink.ingredients
                            .prefix(4)
                            .map { $0.name }
                            .joined(separator: " · ")
                    )
                    .font(ThemeFont.listSubtitle.weight(.medium))
                    .foregroundStyle(.accentRed)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 8)
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial.opacity(0.2))
        .cornerRadius(20)
        .shadow(radius: 6)
    }

    private var glassLine: String {
        if showGlass {
            return "\(drink.category) · \(drink.alcoholic) · \(drink.glass)"
        } else {
            return "\(drink.category) · \(drink.alcoholic)"
        }
    }
}
