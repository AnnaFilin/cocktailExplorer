//
//  MixLabHeaderView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 17/06/2025.
//

import SwiftUI

struct MixLabHeaderView: View {
    @EnvironmentObject var viewModel: IngredientFilterViewModel
    
    var body: some View {
        VStack(spacing: ThemeSpacing.elementSpacing) {
            
            SectionHeaderView(title: "By Composition", subtitle: "What lies beneath the flavor.", alignment: .center)
            
            SearchFieldView(searchText: $viewModel.searchText, isDark: true)
                .padding(.vertical, 8)
        }
        .padding(.top, ThemeSpacing.sectionTop)
    }
}

#Preview {
    MixLabHeaderView()
        .environmentObject(IngredientFilterViewModel())
}
