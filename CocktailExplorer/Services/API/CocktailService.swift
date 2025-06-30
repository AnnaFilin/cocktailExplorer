//
//  CocktailService.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 02/06/2025.
//

import Foundation


struct CocktailService: CocktailServiceProtocol {

    
    private let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/"
    
    func fetchCocktailsList() async throws -> [Drink] {
        
        let url = URL(string: "\(baseURL)/filter.php?c=Cocktail")!

        let response: DrinkResponse = try await fetchAndDecode(from: url)
           return response.drinks
    }
    
    func fetchCocktailById(drinkId: String) async throws -> DrinkDetail {
         let url = URL(string: "\(baseURL)/lookup.php?i=\(drinkId)")!

//        let (data, response) = try await URLSession.shared.data(from: url)
//
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw URLError(.badServerResponse)
//        }
//
//        let decoder = JSONDecoder()
//        let drinkResponse: DrinkDetailsResponse
//
//        do {
//            drinkResponse = try decoder.decode(DrinkDetailsResponse.self, from: data)
//            return drinkResponse.drinks[0]
//        } catch {
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print(jsonString)
//            }
//            throw error
//        }
        let response: DrinkDetailsResponse = try await fetchAndDecode(from: url)
          return response.drinks[0]
    }
    
    func fetchCocktailByName(query: String) async throws -> [DrinkDetail] {
        
        let url = URL(string: "\(baseURL)/search.php?s=\(query)")!
        
        let response: DrinkDetailsResponse = try await fetchAndDecode(from: url)
             return response.drinks
    }
    
    func fetchCocktailsByCategory(query: String) async throws -> [Drink] {
        let url = URL(string: "\(baseURL)/filter.php?c=\(query)")!

        let response: DrinkResponse = try await fetchAndDecode(from: url)
              return response.drinks
    }
    
    func fetchRandomDrink() async throws -> DrinkDetail {
        let url = URL(string: "\(baseURL)/random.php")!
        
        let response: DrinkDetailsResponse = try await fetchAndDecode(from: url)
              return response.drinks[0]
    }
    
    func fetchAllIngredients() async throws -> [BasicIngredient] {
        let url = URL(string: "\(baseURL)/list.php?i=list")!
        
        let response: BasicIngridientResponse = try await fetchAndDecode(from: url)
            return response.drinks
    }
    
    func fetchDrinksByIngredient(ingredient: String) async throws -> [Drink] {
        let url = URL(string: "\(baseURL)/filter.php?i=\(ingredient)")!
        
        let response: DrinkResponse = try await fetchAndDecode(from: url)
             return response.drinks
    }
    
    func fetchIngredientByName(query: String) async throws -> IngredientDetail {
        let url = URL(string: "\(baseURL)/search.php?i=\(query)")!
        
        let response: IngredientDetailResponse = try await fetchAndDecode(from: url)
            return response.ingredients[0]
    }
    
    private func fetchAndDecode<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Decoding failed. Raw JSON:\n\(jsonString)")
            }
            throw error
        }
    }

}
