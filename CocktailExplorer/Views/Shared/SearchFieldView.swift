//
//  SearchFieldView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 09/06/2025.
//

import SwiftUI

struct SearchFieldView: View {
    
    @Binding var searchText: String
    var onToggleFavorites: (() -> Void)? = nil
    var isDark: Bool
//    var isOnlyFavorites: Bool? = nil
    
    var body: some View {
        HStack {
            HStack{
                ZStack(alignment: .leading) {
                    if searchText.isEmpty {
                        Text(isDark ? "Search ingredient..." : "Search drinks...")
                            .foregroundColor(isDark ? .backgroundLight.opacity(0.5) : .backgroundDark.opacity(0.5))
                    }
                    
                    TextField("", text: $searchText)
                        .font(.system(size: 16))
                        .foregroundStyle(isDark ? .backgroundLight : .backgroundDark)
                }
                
                if !searchText.isEmpty {
                    Button(action:{
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 18))
                            .foregroundStyle(isDark ? .backgroundLight : .backgroundDark .opacity(0.7))
                    }
                    .padding(.leading, ThemeSpacing.small)         
                }
                
                Image(systemName: "magnifyingglass")
                    .font(.body)
                    .foregroundStyle(isDark ? .backgroundLight : .backgroundDark)
                    .padding(.trailing, ThemeSpacing.medium)
            }
            
//            if let isOnlyFavorites = isOnlyFavorites,
//               let onToggleFavorites = onToggleFavorites {
//                Button(action: onToggleFavorites) {
//                    Label("Only ", systemImage: isOnlyFavorites ? "heart.fill" : "heart")
//                        .labelStyle(.iconOnly)
//                        .foregroundStyle(.backgroundDark .opacity(0.7))
//                }
//                .padding(.trailing, ThemeSpacing.small)
//            }
        }
        .padding(.vertical, ThemeSpacing.small)
        .padding(.leading, ThemeSpacing.small)
        .background(
            RoundedRectangle(cornerRadius: ThemeSpacing.cornerRadiusSmall)
                .fill(.ultraThinMaterial.opacity(0.5))
        )
        .overlay(
            RoundedRectangle(cornerRadius: ThemeSpacing.cornerRadiusSmall)
                .stroke(isDark ? .backgroundLight.opacity(0.2) : .backgroundDark.opacity(0.2), lineWidth: ThemeSize.borderLineWidth)
        )
    }
}


#Preview {
    SearchFieldView(searchText: .constant(""), onToggleFavorites: {}, isDark: true)
    
}
