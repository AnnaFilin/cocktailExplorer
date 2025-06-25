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

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let drinkResponse = try JSONDecoder().decode(DrinkResponse.self, from: data)
        return drinkResponse.drinks
    }
    
    func fetchCocktailById(drinkId: String) async throws -> DrinkDetail {
         let url = URL(string: "\(baseURL)/lookup.php?i=\(drinkId)")!

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        let drinkResponse: DrinkDetailsResponse

        do {
            drinkResponse = try decoder.decode(DrinkDetailsResponse.self, from: data)
            return drinkResponse.drinks[0]
        } catch {
            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
            }
            throw error
        }
    }
    
    func fetchCocktailByName(query: String) async throws -> [DrinkDetail] {
        
        let url = URL(string: "\(baseURL)/search.php?s=\(query)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let drinkResponse = try JSONDecoder().decode(DrinkDetailsResponse.self, from: data)
      
        return drinkResponse.drinks
        
    }
    
    func fetchCocktailsByCategory(query: String) async throws -> [Drink] {
        let url = URL(string: "\(baseURL)/filter.php?c=\(query)")!

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let drinkResponse = try JSONDecoder().decode(DrinkResponse.self, from: data)
        return drinkResponse.drinks
    }
    
    func fetchRandomDrink() async throws -> DrinkDetail {
        let url = URL(string: "\(baseURL)/random.php")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let drinkResponse = try JSONDecoder().decode(DrinkDetailsResponse.self, from: data)
      
        return drinkResponse.drinks[0]
    }
    
    func fetchAllIngredients() async throws -> [BasicIngredient] {
        let url = URL(string: "\(baseURL)/list.php?i=list")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let basicIngredientsResponse = try JSONDecoder().decode(BasicIngridientResponse.self, from: data)
      
        return basicIngredientsResponse.drinks
    }
    
    func fetchDrinksByIngredient(ingredient: String) async throws -> [Drink] {
        let url = URL(string: "\(baseURL)/filter.php?i=\(ingredient)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let drinkResponse = try JSONDecoder().decode(DrinkResponse.self, from: data)
      
        return drinkResponse.drinks
    }
    
    func fetchIngredientByName(query: String) async throws -> IngredientDetail {
        let url = URL(string: "\(baseURL)/search.php?i=\(query)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let ingredientResponse = try JSONDecoder().decode(IngredientDetailResponse.self, from: data)
      
        return ingredientResponse.ingredients[0]
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
