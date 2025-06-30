//
//  DrinkLargeCardView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 24/06/2025.
//
import SwiftUI

struct DrinkCardView: View {
    let drink: DrinkDetail
    var width: CGFloat
    var height: CGFloat 
    var imageRatio: CGFloat = 0.6
    var showIngredients: Bool = true
    var alignment: HorizontalAlignment = .center
    var font: Font = ThemeFont.drinkTitle

    var body: some View {
        let imageSize = height * imageRatio

        VStack(alignment: alignment, spacing: ThemeSpacing.elementSpacing) {
            Text(drink.name)
                .font(font)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.7)
                      .frame(maxWidth: .infinity)
                      .frame(height: ThemeSize.drinkCardTitleHeight)
                      .padding(.horizontal, ThemeSpacing.small)

            AsyncImage(url: URL(string: drink.thumbnail)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageSize, height: imageSize)
                        .clipped()
                        .cornerRadius(ThemeSpacing.cornerRadiusSmall)
                } else {
                    Image(systemName: "photo")
                }
            }

            VStack(alignment: alignment, spacing: ThemeSpacing.elementSpacing) {
                Text("\(drink.category) · \(drink.alcoholic)")
                  .font(ThemeFont.captionRegular)
                  .foregroundStyle(.backgroundLight.opacity(0.85))
                  .lineLimit(1)
                  .truncationMode(.tail)
                  .multilineTextAlignment(.center)
                  .frame(maxWidth: .infinity)
                  .padding(.horizontal, ThemeSpacing.small)
                
                if showIngredients {
                    Text(
                        drink.ingredients
                            .prefix(3)
                            .map { $0.name }
                            .joined(separator: " · ")
                    )
                    .font(ThemeFont.captionMedium)
                    .foregroundStyle(.accentRed)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, ThemeSpacing.small)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .padding()
        .frame(width: width, height: height)
        .background(.ultraThinMaterial.opacity(0.2))
        .cornerRadius(ThemeSpacing.cornerRadiusLarge)
        .shadow(radius: ThemeSpacing.shadowRadius)
    }
}
