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
    
    var body: some View {
        
        
        HStack {
            HStack{
                ZStack(alignment: .leading) {
                    if searchText.isEmpty {
                        Text(isDark ? "Search ingredient..." : "Search drinks...")
                            .foregroundColor(isDark ? .backgroundLight.opacity(0.5) : .backgroundDark.opacity(0.5))
                            .padding(.leading, 16)
                    }

                    TextField("", text: $searchText)
                        .font(.system(size: 16))
                        .foregroundStyle(isDark ? .backgroundLight : .backgroundDark)
                        .padding(.horizontal)
                }

                if !searchText.isEmpty {
                    Button(action:{
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 18))
                            .foregroundStyle(isDark ? .backgroundLight : .backgroundDark .opacity(0.7))
                     
                    }
                    .padding(.trailing, 10)
                }
                
                Image(systemName: "magnifyingglass")
                    .font(.body)
                    .foregroundStyle(isDark ? .backgroundLight : .backgroundDark)
                    .padding(.trailing, 6)
                
            }
            .padding(10)
            
            .padding(.horizontal, 6)
            
            Spacer()
            
            if let onToggleFavorites = onToggleFavorites {
                    Button(action: onToggleFavorites) {
                        Label("Only ", systemImage: "heart.fill")
                            .labelStyle(.iconOnly)
                            .foregroundStyle(.backgroundDark .opacity(0.7))
                        
                    }
                    .padding(10)
                    
                }
            
            
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial.opacity(0.5))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isDark ? .backgroundLight.opacity(0.2) : .backgroundDark.opacity(0.2), lineWidth: 1)
        )
    }
}


#Preview {
    SearchFieldView(searchText: .constant(""), onToggleFavorites: {}, isDark: true)

}
