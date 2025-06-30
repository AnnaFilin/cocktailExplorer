//
//  DrinkOfTheDayBannerView.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 09/06/2025.
//



import SwiftUI

struct DrinkOfTheDayBannerView: View {
    @EnvironmentObject var drinksViewModel: DrinksViewModel
    
    var body: some View {
        VStack(alignment: .center){
            if let randomDrink = drinksViewModel.randomDrink {
                
                Text(randomDrink.name)
                    .font(ThemeFont.drinkTitle)
                    .foregroundStyle(.backgroundDark)
                    .opacity(0.85)
                
                AsyncImage(url: URL(string: randomDrink.thumbnail)) {  phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: ThemeSize.drinkBannerMaxWidth)
                            .cornerRadius(ThemeSpacing.cornerRadiusSmall)
                            .shadow(radius: ThemeSpacing.shadowRadius/2)
                        
                    } else if phase.error != nil {
                        Text("No image available")
                    } else {
                        ProgressView()
                    }
                }
                .id(randomDrink.id)
            }
        }
        .onAppear() {
            Task {
                if drinksViewModel.randomDrink == nil {
                    await drinksViewModel.loadRandomDrink()
                }
            }
        }
    }
}

#Preview {
    DrinkOfTheDayBannerView()
        .environmentObject(DrinksViewModel.preview)
}
