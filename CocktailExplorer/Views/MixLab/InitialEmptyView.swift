//
//  InitialEmptyView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 23/06/2025.
//

import SwiftUI

struct InitialEmptyView: View {
 
    let lines = ["Before", "anything", "blends."]
    @State private var visibleLines: [Bool] = [false, false, false]
    @State private var showSubline = false

    
    var body: some View {
        VStack(spacing: 8) {
                  ForEach(0..<lines.count, id: \.self) { index in
                      Text(lines[index])
                          .font(.custom("Georgia", size: 36).weight(.semibold))
                          .foregroundStyle(.backgroundLight.opacity(0.8))
                          .multilineTextAlignment(.center)
                          .padding(.top, index == 0 ? 16 : 0)
                          .scaleEffect(visibleLines[index] ? 1 : 0.8)
                          .opacity(visibleLines[index] ? 1.0 : 0.0)
                          .blur(radius: visibleLines[index] ? 0 : 4)
                          .animation(
//                              .easeOut(duration: 1.2).delay(Double(index) * 0.8),
//                              value: visibleLines[index]
//                          )
                            .spring(response: 1.0, dampingFraction: 0.85), value: visibleLines[index]
                            )
                  }

                  if showSubline {
                      Text("What lies beneath the flavor.")
                          .font(ThemeFont.listTitle)
                          .foregroundStyle(.backgroundLight.opacity(0.8))
                          .multilineTextAlignment(.center)
                          .padding(.top, 16)
                          .opacity(showSubline ? 1.0 : 0.0)
                          .scaleEffect(showSubline ? 1.0 : 0.95)
                          .blur(radius: showSubline ? 0 : 2)
                          .animation(.easeOut(duration: 1.0), value: showSubline)
                  }
              }
              .padding(.horizontal, 24)
              .padding(.top, 80)
              .onAppear {
                  for i in 0..<lines.count {
                      DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.8) {
                          visibleLines[i] = true
                      }
                  }
                  DispatchQueue.main.asyncAfter(deadline: .now() + Double(lines.count) * 0.8 + 1.2) {
                      showSubline = true
                  }
              }
          
    }
}

#Preview {
    InitialEmptyView()
}
