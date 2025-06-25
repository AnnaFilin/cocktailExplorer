//
//  SectionHeaderView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 24/06/2025.
//

import SwiftUI


//struct SectionHeaderView: View {
//    let title: String
//    let subtitle: String?
//    let alignment: Alignment
//    
//    var body: some View {
//        VStack(spacing: ThemeSpacing.elementSpacing) {
//            Text(title)
//                .font(ThemeFont.drinkTitle)
//                .frame(maxWidth: .infinity, alignment: alignment)
//            
//            if let subtitle = subtitle {
//                Text(subtitle)
//                    .font(ThemeFont.sectionLabel)
//                    .lineLimit(2)
//                    .multilineTextAlignment(.center)
//                    .foregroundStyle(.backgroundLight.opacity(0.8))
//                    .padding(.horizontal, ThemeSpacing.horizontal)
//                    .padding(.bottom, 12)
//                    .frame(maxWidth: .infinity, alignment: alignment)
//            }
//        }
//        .padding(.top, ThemeSpacing.sectionTop)
//              .padding(.horizontal, ThemeSpacing.horizontal)
//    }
//    
//    
//}
struct SectionHeaderView: View {
    let title: String
    let subtitle: String?
    let alignment: Alignment
    
    var body: some View {
        VStack(spacing: ThemeSpacing.headerVerticalSpacing) {
            Text(title)
                .font(ThemeFont.sectionTitle)
                .frame(maxWidth: .infinity, alignment: alignment)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(ThemeFont.sectionSubtitle)
                    .lineLimit(2)
                    .multilineTextAlignment(alignment == .leading ? .leading : .center)
                    .foregroundStyle(.backgroundLight.opacity(0.8))
                    .frame(maxWidth: .infinity, alignment: alignment)
            }
        }
        .padding(.top, ThemeSpacing.sectionTop)
        .padding(.horizontal, ThemeSpacing.horizontal)
        .padding(.bottom, ThemeSpacing.sectionBottom)
    }
}

#Preview {
    SectionHeaderView( title: "Favorites",
                       subtitle: "The drinks you loved the most.",
                       alignment: .center)
}
