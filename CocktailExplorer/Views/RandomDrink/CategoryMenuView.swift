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

            VStack (spacing: 8){
                Text("·  The Menu  ·")
                    .font(ThemeFont.drinkTitle)
                    .padding(.top, 8)
                
                Text("Refine the random.")
                    .font(ThemeFont.listTitle)
                    .opacity(0.8)
                       .padding(.bottom, 2)

                
                HStack {
                    
                VStack(spacing: 4) {
                       lineDecoration
                       lineDecoration
                   }
                    Image("cocktail")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.backgroundDark)
                    VStack(spacing: 4) {
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
                .background(
                       RoundedRectangle(cornerRadius: 4)
                           .fill(Color.backgroundLight)
                           .shadow(color: .backgroundDark.opacity(0.1), radius: 1, x: 1, y: 2)
                   )
                
            }
            .padding(.bottom, 12)
            .padding(.horizontal, 24)
            .foregroundStyle(.backgroundDark)
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(.backgroundDark.opacity(0.7), lineWidth: 1)
            )
            .padding(6)
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(.backgroundDark.opacity(0.9), lineWidth: 0.5)
            )
            .padding(6)
            .background(.backgroundLight)
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(.clear, lineWidth: 0.5)
            )
    }
    
    var lineDecoration: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.secondary)
            .opacity(0.5)
            .padding(.vertical,0)
    }
    
}

struct CategoryDotLine: View {
    let title: String
    
    var body: some View {
        ZStack {
            DottedLine()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [2, 4]))
                .foregroundColor(.gray.opacity(0.5))
                .frame(height: 1)
                .padding(.horizontal)
            
            Text(title)
                .font(ThemeFont.listTitle)
                .foregroundColor(.backgroundDark)
                .padding(.horizontal, 8)
                .background(Color.backgroundLight)
        }
        .padding(.vertical, 6)
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


struct CategoryLine: View {
    let title: String
    
    var body: some View {
        HStack(spacing: 6) {
            lineDecoration
            
            Text(title)
                .font(ThemeFont.listTitle)
                .foregroundColor(.backgroundDark)
                .lineLimit(1)
                .layoutPriority(1)

            lineDecoration
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 4)
    }
    
    var lineDecoration: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.secondary)
            .opacity(0.5)
    }
}



#Preview {
    CategoryMenuView(selectedCategory: .constant("Homemade Liqueur"))
}
