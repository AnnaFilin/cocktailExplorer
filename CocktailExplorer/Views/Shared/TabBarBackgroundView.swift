//
//  TabBarBackgroundView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 11/06/2025.
//

import SwiftUI

struct TabBarBackgroundView: View {
    
    @Binding var selectedTab: Tab
    @Binding var backgroundColor: Color

       var body: some View {
           HStack {
               Spacer()
               
               tabItem(icon: "magnifyingglass", tab: .search)
               
               Spacer()
               
               tabItem(icon: "die.face.5", tab: .random)
               
               Spacer()
               
               tabItem(icon: "leaf", tab: .mixBy)
               
               Spacer()
               
               tabItem(icon: "heart", tab: .favorites)
               
               Spacer()
               
           }
         
           .padding(.top, 12)

           .background(
               backgroundColor.opacity(0.6)
           )
           .background(.ultraThinMaterial)

           .onAppear(){
               withAnimation(.easeInOut(duration: 1.2))  {
                   backgroundColor = backgroundColor == .backgroundDark ? .backgroundLight : .backgroundDark
               }

           }
       }

       func tabItem(icon: String, tab: Tab) -> some View {
           Button(action: {
               withAnimation {
                   selectedTab = tab
               }
           }) {
               Image(systemName: icon)
                   .font(.system(size: 22, weight: .medium))
                   .foregroundColor(selectedTab == tab ? .accentRed : .gray)
           }
       }
   
}

#Preview {
    TabBarBackgroundView(selectedTab: .constant(.search), backgroundColor: .constant(.backgroundLight))
}
