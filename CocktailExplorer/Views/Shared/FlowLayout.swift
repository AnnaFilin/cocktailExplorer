//
//  FlowLayout.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 11/06/2025.
//

import Foundation
import SwiftUI
import UIKit

struct FlowLayout<T: Hashable, Content: View>: View {
    let items: [T]
    let spacing: CGFloat
    let content: (T) -> Content

    init(items: [T], spacing: CGFloat = 8, @ViewBuilder content: @escaping (T) -> Content) {
        self.items = items
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        FlexibleView(data: items, spacing: spacing, alignment: .leading) { item in
            content(item)
        }
    }
}


struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content

    init(data: Data,
         spacing: CGFloat = 8,
         alignment: HorizontalAlignment = .leading,
         @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.spacing = spacing
        self.alignment = alignment
        self.content = content
    }

    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(computeRows(), id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(row, id: \.self) { item in
                        content(item)
                    }
                }
            }
        }
    }

    private func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRowWidth: CGFloat = 0

        let screenWidth = UIScreen.main.bounds.width - 32

        for item in data {
            let label = itemLabel(item)
            let itemWidth = label.widthOfString(usingFont: UIFont.systemFont(ofSize: 16)) + 32

            if currentRowWidth + itemWidth > screenWidth {
                rows.append([item])
                currentRowWidth = itemWidth
            } else {
                rows[rows.count - 1].append(item)
                currentRowWidth += itemWidth
            }
        }

        return rows
    }

    private func itemLabel(_ item: Data.Element) -> String {
        if let string = item as? String {
            return string
        } else if let ingredient = item as? BasicIngredient {
            return ingredient.name
        } else {
            return String(describing: item)
        }
    }
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes).width
    }
}
