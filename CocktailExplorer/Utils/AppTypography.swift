//
//  AppTypography.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 09/06/2025.
//

import Foundation
import SwiftUI

    enum ThemeFont {
        static let sectionTitle = Font.custom("Georgia", size: 28).weight(.semibold)
        static let sectionSubtitle = Font.custom("Georgia", size: 16)

        
    static let drinkTitle = Font.custom("Georgia", size: 36).weight(.semibold)
    static let largeTitle = Font.custom("Georgia", size: 28).weight(.light)
    static let sectionLabel = Font.custom("Georgia", size: 18)
    static let drinkDescription = Font.custom("Georgia", size: 16)
    static let searchField = Font.system(size: 16)
    static let listTitle = Font.custom("Georgia", size: 18).weight(.semibold)
    static let listSubtitle = Font.system(size: 14)
    static let iconSize = Font.system(size: 20)
}
