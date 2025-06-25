//
//  Drink.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 02/06/2025.
//

import Foundation

struct DrinkResponse: Codable {
    let drinks: [Drink]
    
    
}

struct Drink: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case thumbnail = "strDrinkThumb"
    }
    
    static let allDrinks: [Drink] = Bundle.main.decode("MockDrinks.json")
    static let example = allDrinks[0]
}
