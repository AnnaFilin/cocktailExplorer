//
//  DrinkDetailView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 02/06/2025.
//

import SwiftUI

struct DrinkDetailView: View {
    @EnvironmentObject var  drinksViewModel: DrinksViewModel
    
    let drinkId: String
    @Binding var backgroundColor: Color
    
    @State private var backgroundOpacity: Double = 0
    
    
    var body: some View {
        ZStack {
            backgroundColor
                .opacity(backgroundOpacity)
                .ignoresSafeArea()
            
            
            VStack{
                if drinksViewModel.isLoading || drinksViewModel.currentDrink == nil {
                    VStack {
                        Spacer()
                        ProgressView("Loading drink...")
                            .progressViewStyle(CircularProgressViewStyle())
                        Spacer()
                    }
                    .transition(.opacity)
                    
                } else if let currentDrink = drinksViewModel.currentDrink {
                    
                    
                    ScrollView {
                        
                        VStack(alignment: .center, spacing: 12) {
                            
                            AsyncImage(url: URL(string: currentDrink.thumbnail)) {  phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 14)) 
                                        .shadow(radius: 6)
                                    
                                } else if phase.error != nil {
                                    Text("No image available")
                                } else {
                                    Image(systemName: "photo")
                                }
                            }
                            .frame(maxWidth: 300, maxHeight: 240)
                            .padding(.bottom, 8)
                            .shadow(radius: 5)
                            
                            Spacer()
                            
                            VStack(spacing: 6)  {
                                
                                Text(currentDrink.name)
                                    .font(ThemeFont.drinkTitle)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.backgroundLight)
                                
                                Text(currentDrink.category.uppercased())
                                    .font(ThemeFont.sectionLabel)
                                    .foregroundStyle(.backgroundLight.opacity(0.8))
                                    .padding(.top, 2)
                                    .tracking(1)
                            }
                            
                            FavoritesButtonView(drinkId: currentDrink.id )
                                .font(.system(size: 26, weight: .medium))
                                .foregroundStyle(.accentRed)
                        }
                        .padding(.top, 12)
                        
                        VStack (alignment: .leading, spacing: 0){
                            Text("Ingridients")
                                .modifier(SectionHeaderStyle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                ForEach(currentDrink.ingredients, id: \.id) { ingredient in
                                    Text("• \(ingredient.name)")
                                        .modifier(SectionBodyStyle())
                                }
                                
                            }
                            
                            .padding(.vertical, 16)
                            
                            Text("Instructions")
                                .modifier(SectionHeaderStyle())
                                .padding(.top, 12)
                            
                            Text(currentDrink.instructions)
                                .modifier(SectionBodyStyle())
                            
                                .multilineTextAlignment(.leading)
                                .lineSpacing(6)
                            
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 16)
                            
                            HStack(spacing: 32) {
                                VStack(alignment: .leading) {
                                    Text("Glass")
                                        .modifier(SectionHeaderStyle())
                                    
                                    Text(currentDrink.glass)
                                        .modifier(SectionBodyStyle())
                                    
                                }
                                
                                VStack(alignment: .leading)  {
                                    Text("Category")
                                        .modifier(SectionHeaderStyle())
                                    
                                    Text(currentDrink.category)
                                        .modifier(SectionBodyStyle())
                                    
                                }
                                .padding(.leading)
                            }
                            .padding(.vertical)
                            
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .transition(.opacity)
                } else if let error = drinksViewModel.currentErrorMessage {
                    VStack {
                        Spacer()
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    }
                }
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.backgroundDark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
        }
        .onAppear {
            backgroundColor = .backgroundDark
            backgroundOpacity = 0
            
            withAnimation(.easeInOut(duration: 1.5)) {
                backgroundOpacity = 1
            }
            
            Task {
                await drinksViewModel.loadDrinkDetail(drinkId: drinkId)
            }
        }
        
        .onDisappear {
            drinksViewModel.currentDrink = nil
        }
        
    }
}


struct SectionHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(.backgroundLight)
            .textCase(.uppercase)
    }
}

struct SectionBodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundStyle(.textPrimary)
    }
}

#Preview {
    DrinkDetailView(drinkId: "178336", backgroundColor: .constant(.backgroundDark))
        .environmentObject(DrinksViewModel.preview)
}
