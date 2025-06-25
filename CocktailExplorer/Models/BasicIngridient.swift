//
//  BasicIngridient.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 08/06/2025.
//

import Foundation

struct BasicIngridientResponse : Codable {
   let drinks: [BasicIngredient]
}

struct BasicIngredient: Identifiable, Codable, Hashable {
    var id: String { name }
    let name: String

    enum CodingKeys: String, CodingKey {
        
        case name = "strIngredient1"
    }

    static let example = BasicIngredient(name: "Vodka")

}
