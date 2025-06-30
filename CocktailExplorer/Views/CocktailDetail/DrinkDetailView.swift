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
                        VStack(alignment: .center, spacing: ThemeSpacing.elementSpacing) {
                            AsyncImage(url: URL(string: currentDrink.thumbnail)) {  phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: ThemeSpacing.cornerRadiusSmall))
                                                   .shadow(radius: ThemeSpacing.shadowRadius)
                                    
                                } else if phase.error != nil {
                                    Text("No image available")
                                } else {
                                    Image(systemName: "photo")
                                }
                            }
                            .frame(maxWidth: ThemeSize.drinkBannerMaxWidth)
                            
                            VStack(spacing: ThemeSpacing.compact)  {
                                
                                Text(currentDrink.name)
                                    .font(ThemeFont.drinkTitle)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.backgroundLight)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                
                                Text(currentDrink.category.uppercased())
                                    .font(ThemeFont.sectionLabel)
                                    .foregroundStyle(.backgroundLight.opacity(0.8))
                                    .tracking(1)
                            }
                            
                            FavoritesButtonView(drinkId: currentDrink.id)
                                .font(.system(size: ThemeSize.iconSizeFavorite, weight: .medium))
                                .foregroundStyle(.accentRed)

                        }
                        .padding(.horizontal, ThemeSpacing.horizontal)
                        
                        VStack (alignment: .leading,  spacing: ThemeSpacing.elementSpacing){
                            Text("Ingridients")
                                .modifier(SectionHeaderStyle())
                            
                            VStack(alignment: .leading, spacing: ThemeSpacing.compact) {
                                ForEach(currentDrink.ingredients, id: \.id) { ingredient in
                                    Text("• \(ingredient.name)")
                                        .modifier(SectionBodyStyle())
                                }
                            }

                            Text("Instructions")
                                .modifier(SectionHeaderStyle())
                            
                            Text(currentDrink.instructions)
                                .modifier(SectionBodyStyle())
                            
                                .multilineTextAlignment(.leading)
                                .lineSpacing(6)
                            
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack(spacing: ThemeSpacing.large) {
                                VStack(alignment: .leading) {
                                    Text("Glass")
                                        .modifier(SectionHeaderStyle())
                                    
                                    Text(currentDrink.glass)
                                        .modifier(SectionBodyStyle())
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .leading)  {
                                    Text("Category")
                                        .modifier(SectionHeaderStyle())
                                    
                                    Text(currentDrink.category)
                                        .modifier(SectionBodyStyle())
                                    
                                }
                                Spacer()
                            }
                            
                        }
                        .padding(.horizontal, ThemeSpacing.horizontal)
                        .padding(.top, ThemeSpacing.elementSpacing)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .transition(.opacity)
                } else if let error = drinksViewModel.currentErrorMessage {
                    VStack {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)

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
            .font(ThemeFont.sectionHeader)
            .foregroundStyle(.backgroundLight)
            .textCase(.uppercase)
    }
}

struct SectionBodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(ThemeFont.captionRegular)
            .foregroundStyle(.textPrimary)
    }
}

#Preview {
    DrinkDetailView(drinkId: "178336", backgroundColor: .constant(.backgroundDark))
        .environmentObject(DrinksViewModel.preview)
}
