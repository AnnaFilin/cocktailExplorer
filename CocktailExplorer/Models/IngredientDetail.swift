//
//  IngredientDetail.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 19/06/2025.
//

import Foundation

struct IngredientDetailResponse: Codable {
    let ingredients: [IngredientDetail]
}

struct IngredientDetail: Identifiable, Codable {
    var id: String { idIngredient }
    
    let idIngredient: String
    let strIngredient: String
    let strDescription: String?
    let strType: String?
    let strAlcohol: String?
    let strABV: String?
    
    static let ingredient: IngredientDetail = Bundle.main.decode("MockIngredientDetails.json")
    static let example = ingredient
}
