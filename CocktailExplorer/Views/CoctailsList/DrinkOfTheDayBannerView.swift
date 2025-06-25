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
       
                           Text("Drink of the Day")
                               .font(ThemeFont.sectionLabel)
                               .textCase(.uppercase)
                                  .kerning(1)
                               .foregroundStyle(.backgroundDark)
                               .padding(.top, 24)
       
                           Text(randomDrink.name)
                               .font(ThemeFont.drinkTitle)
                               
                               .foregroundStyle(.backgroundDark)
                               .padding(.top, 6)
       
       
                           AsyncImage(url: URL(string: randomDrink.thumbnail)) {  phase in
                               if let image = phase.image {
                                   image
                                       .resizable()
                                          .scaledToFit()
                                          .frame(maxWidth: 280) 
                                          .cornerRadius(10)

       
                               } else if phase.error != nil {
                                   Text("No image available")
                               } else {
                                   Image(systemName: "photo")
                               }
                           }
                           .id(randomDrink.id)
                           .shadow(radius: 3)
                           .padding(.horizontal)
       
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
