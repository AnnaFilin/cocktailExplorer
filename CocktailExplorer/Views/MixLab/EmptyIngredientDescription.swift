//
//  EmptyIngredientDescription.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 23/06/2025.
//

import SwiftUI

struct EmptyIngredientDescription: View {
    let ingredientName: String
    @State private var showHint = false
    
    var body: some View {
        ZStack(alignment: .center) {
            AsyncImage(
                url: URL(string: "https://www.thecocktaildb.com/images/ingredients/\(ingredientName)-Medium.png")
            ) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                               .frame(width: 200, height: 400)
                               .clipped()
                               .blur(radius: 2)
                    .cornerRadius(12)
                    .opacity(0.3)
                    .frame(maxWidth: .infinity)
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }

            
            VStack(spacing: 16) {
                Text("Some ingredients")
                    .font(ThemeFont.largeTitle)
                    
                
                Text("speak for themselves.")
                    .font(ThemeFont.largeTitle)
                
            }
            .multilineTextAlignment(.center)
                       .padding(.horizontal, 16)
                       .opacity(showHint ? 0.7 : 0)
                       .offset(y: showHint ? 0 : 20)
                       .animation(.easeOut(duration: 1.2), value: showHint)
                   }
                   .onAppear {
                       showHint = true
                   }
                   .frame(maxWidth: .infinity)

        
    }
}

#Preview {
    EmptyIngredientDescription(ingredientName: "Tequila")
}
