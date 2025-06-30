//
//  CategoryMenuView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 21/06/2025.
//

import SwiftUI

struct CategoryMenuView: View {
    private let categories: [String] = ["Cocktail","Ordinary Drink" ,"Punch / Party Drink" ,"Shake","Other / Unknown","Cocoa","Shot","Coffee / Tea","Homemade Liqueur","Beer","Soft Drink"]
    
    @Binding var selectedCategory: String?
    var onSelect: (() -> Void)? = nil
    
    var body: some View {

            VStack (spacing:ThemeSpacing.none){
                Text("·  The Menu  ·")
                    .font(ThemeFont.drinkTitle)
                    .padding(.top, ThemeSpacing.small)
                
                Text("Refine the random.")
                    .font(ThemeFont.listTitle)

                HStack {
                    
                VStack(spacing: ThemeSpacing.compact) {
                       lineDecoration
                       lineDecoration
                   }
                    Image("cocktail")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()

                        .frame(width: ThemeSize.iconSizeSmall, height: ThemeSize.iconSizeSmall)
                        .foregroundColor(.backgroundDark)
                    VStack(spacing: ThemeSpacing.compact ) {
                           lineDecoration
                           lineDecoration
                       }
                }

                ForEach(categories, id: \.self) { categorie in
                    CategoryDotLine(title: categorie)
                        .onTapGesture {
                            selectedCategory = categorie
                            onSelect?()
                        }      
                }
            }
            .opacity(0.8)
            .padding(.bottom, ThemeSpacing.medium)
            .padding(.horizontal, ThemeSpacing.horizontal)
            .foregroundStyle(.backgroundDark)
            .overlay(
                RoundedRectangle(cornerRadius: ThemeSpacing.none)
                    .stroke(.backgroundDark.opacity(0.6), lineWidth: ThemeSize.borderLineWidth)
            )
            .padding(ThemeSpacing.small)
            .overlay(
                RoundedRectangle(cornerRadius: ThemeSpacing.none)
                    .stroke(.backgroundDark.opacity(0.9), lineWidth:  ThemeSize.borderLineWidthThin)
            )
            .padding(ThemeSpacing.small)
            .background(.backgroundLight)
            .overlay(
                RoundedRectangle(cornerRadius: ThemeSpacing.none)
                    .stroke(.clear, lineWidth: ThemeSize.borderLineWidthThin)
            )
    }
    
    var lineDecoration: some View {
        Rectangle()
            .frame(height: ThemeSize.borderLineWidth)
            .foregroundColor(.backgroundDark)
            .opacity(0.5)
            .padding(.vertical,ThemeSpacing.none)
    }
    
}

struct CategoryDotLine: View {
    let title: String
    
    var body: some View {
        ZStack {
            DottedLine()
                .stroke(style: StrokeStyle(lineWidth:  ThemeSize.borderLineWidth, dash: [2, 4]))
                .foregroundColor(.backgroundDark.opacity(0.5))
                .frame(height:  ThemeSize.borderLineWidth)
                .padding(.horizontal)
            
            Text(title)
                .font(ThemeFont.listTitle)
                .foregroundColor(.backgroundDark)
                .padding(.horizontal, ThemeSpacing.small)
                .background(Color.backgroundLight)
        }

        .padding(.horizontal, ThemeSpacing.small)
        .padding(.vertical, ThemeSpacing.compact)
        .background(
            RoundedRectangle(cornerRadius: ThemeSpacing.compact)
                   .fill(.backgroundLight.opacity(0.9))
                   .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 2)
                   .overlay(
                        RoundedRectangle(cornerRadius: ThemeSpacing.compact)
                          .stroke(.backgroundDark.opacity(0.1), lineWidth: ThemeSize.borderLineWidthThin)
                      )
           )
        
    }
}

struct DottedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.width, y: rect.midY))
        return path
    }
}


#Preview {
    CategoryMenuView(selectedCategory: .constant("Homemade Liqueur"))
}
