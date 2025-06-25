//
//  DrinkDetail.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 02/06/2025.
//

import Foundation

struct DrinkDetailsResponse: Codable {
    let drinks: [DrinkDetail]
}

struct DrinkDetail: Codable, Equatable, Hashable {
    static func == (lhs: DrinkDetail, rhs: DrinkDetail) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    
    let id: String
    let name: String
    let category: String
    let glass: String
    let alcoholic: String
    let instructions: String
    let thumbnail: String
    let ingredients: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case glass = "strGlass"
        case alcoholic = "strAlcoholic"
        case instructions = "strInstructions"
        case thumbnail = "strDrinkThumb"
        
       
    }
    
    struct Ingredient: Identifiable, Hashable {
        var id: String { name }
          let name: String
          let measure: String?
      }
    
    
    struct DynamicCodingKey: CodingKey {
           var stringValue: String
           var intValue: Int? { nil }

           init?(stringValue: String) {
               self.stringValue = stringValue
           }

           init?(intValue: Int) {
               return nil
           }
       }

    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKey.self)

            id = try container.decode(String.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)
            category = try container.decode(String.self, forKey: .category)
            glass = try container.decode(String.self, forKey: .glass)
            alcoholic = try container.decode(String.self, forKey: .alcoholic)
            instructions = try container.decode(String.self, forKey: .instructions)
            thumbnail = try container.decode(String.self, forKey: .thumbnail)

            var tempIngredients: [Ingredient] = []
            for i in 1...15 {
                let ingredientKey = DynamicCodingKey(stringValue: "strIngredient\(i)")!
                let measureKey = DynamicCodingKey(stringValue: "strMeasure\(i)")!

                if let ingredient = try dynamicContainer.decodeIfPresent(String.self, forKey: ingredientKey),
                   !ingredient.trimmingCharacters(in: .whitespaces).isEmpty {
                    let measure = try dynamicContainer.decodeIfPresent(String.self, forKey: measureKey)
                    tempIngredients.append(Ingredient(name: ingredient, measure: measure))
                }
            }

            ingredients = tempIngredients
        }
    
    init(
        id: String,
        name: String,
        category: String,
        glass: String,
        alcoholic: String,
        instructions: String,
        thumbnail: String,
        ingredients: [Ingredient]
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.glass = glass
        self.alcoholic = alcoholic
        self.instructions = instructions
        self.thumbnail = thumbnail
        self.ingredients = ingredients
    }

    static let exampleAll: [DrinkDetail] = Bundle.main.decode("MockDrinkDetail.json")
    static let example = exampleAll[0]

}
