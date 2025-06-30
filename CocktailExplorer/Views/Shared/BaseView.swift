//
//  BaseView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 25/06/2025.
//

import SwiftUI

struct BaseView<Content: View>: View {
    
    var backgroundColor: Color
    let content: Content
    
    init(backgroundColor: Color, @ViewBuilder  content: () -> Content) {
        self.backgroundColor = backgroundColor
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            backgroundColor
            
            VStack {
                
                content
                    .foregroundColor(backgroundColor == .backgroundDark ? .backgroundLight : .backgroundDark)
            }
            .padding(.horizontal, ThemeSpacing.horizontal)

        }
        .ignoresSafeArea()
    }
}

#Preview {
    BaseView(backgroundColor: .backgroundLight) {
        }
}
