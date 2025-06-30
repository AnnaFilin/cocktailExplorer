//
//  ThemeSize.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 25/06/2025.
//

import Foundation


import SwiftUI

enum DeviceSize {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    static let isSmallScreen = screenWidth < 375
    static let isLargeScreen = screenWidth > 414
}

enum ThemeScale {
    static let baseWidth: CGFloat = 375 // iPhone 11 baseline
    static let scale: CGFloat = DeviceSize.screenWidth / baseWidth
}

enum ThemeSize {
    static let drinkCardWidth: CGFloat = DeviceSize.screenWidth * 0.85
    static let drinkCardHeight: CGFloat = drinkCardWidth * 1.3
    static let drinkCardTitleHeight: CGFloat = 50 * ThemeScale.scale
    
    static let ingredientCardWidth: CGFloat = 100 * ThemeScale.scale
    static let ingredientCardHeight: CGFloat = 120 * ThemeScale.scale
    static let ingredientSheetImageWidth: CGFloat = 100 * ThemeScale.scale
    static let ingredientSheetImageHeight: CGFloat = 100 * ThemeScale.scale
    
    static let drinkImageSize: CGFloat = 70
    
    static let iconSizeMedium: CGFloat = 40 * ThemeScale.scale
    static let iconSizeSmall: CGFloat = 30 * ThemeScale.scale
    static let iconSizeFavorite: CGFloat = 18
    
    static let borderLineWidth: CGFloat = 1
    static let borderLineWidthThin: CGFloat = 0.5
    static let chipBorderWidth: CGFloat = 1.5
    
    static let suggestionsMaxHeight: CGFloat = 160
    static let drinkBannerMaxWidth: CGFloat = UIScreen.main.bounds.width * 0.75
    
}
enum ThemeSpacing {
    static let horizontal: CGFloat = 20
    static let sectionTop: CGFloat = 40
    static let sectionBottom: CGFloat = 20
    static let headerVerticalSpacing: CGFloat = 12
    static let tabBarIconTopPadding: CGFloat = 12
    static let elementSpacing: CGFloat = 12
    static let small: CGFloat = 8
    static let medium: CGFloat = 12
    static let large: CGFloat = 20
    static let cornerRadiusSmall: CGFloat = 12
    static let cornerRadiusLarge: CGFloat = 20
    static let shadowRadius: CGFloat = 6
    static let compact: CGFloat = 4
    static let none: CGFloat = 0
    
    static let outerPadding: CGFloat = 26
}


enum ThemeFont {
    static var screenLabel: Font {
        Font.system(size: 24, weight: .medium)
    }
    
    static var screenSubtitle: Font {
        Font.custom("Georgia", size: scaled(16))
    }
    static var drinkTitle: Font {
        Font.custom("Georgia", size: scaled(32)).weight(.semibold)
    }
    static var drinkInfo: Font {
        Font.system(size: scaled(14), weight: .regular)
    }
    
    static var sectionHeader: Font {
        Font.custom("Georgia", size: scaled(18)).weight(.semibold)
    }
    
    static var captionRegular: Font {
        Font.system(size: scaled(14), weight: .regular)
    }
    
    static var captionMedium: Font {
        Font.system(size: scaled(14), weight: .medium)
    }
    
    static var smallRegular: Font {
        Font.system(size: scaled(12), weight: .regular)
    }
    
    static var actionButton: Font {
        Font.custom("Georgia", size: scaled(26)).weight(.medium)
    }
    
    static var pillButton: Font {
        Font.system(size: scaled(14), weight: .medium)
    }
    
    static var screenHero: Font {
        Font.custom("Georgia", size: scaled(48)).weight(.bold)
    }
    
    static var favoriteIcon: Font {
        Font.system(size: 18)
    }
    
    static var body: Font {
      Font.custom("Georgia", size: scaled(17)).weight(.regular)
    }

    static let largeTitle = Font.custom("Georgia", size: 28).weight(.light)
    static let sectionLabel = Font.custom("Georgia", size: 18)
    
    static let listTitle = Font.custom("Georgia", size: 18).weight(.semibold)
    static let listSubtitle = Font.system(size: 14)
    
    
    private static func scaled(_ baseSize: CGFloat) -> CGFloat {
        let idiom = UIDevice.current.userInterfaceIdiom
        switch idiom {
        case .pad:
            return baseSize * 1.4
        case .phone:
            return baseSize
        default:
            return baseSize
        }
    }
}

