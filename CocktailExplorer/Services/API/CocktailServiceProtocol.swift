//
//  CocktailServiceProtocol.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 02/06/2025.
//

import Foundation

protocol CocktailServiceProtocol {
    func fetchCocktailsList() async throws -> [Drink]
    func fetchCocktailById(drinkId: String) async throws -> DrinkDetail
    func fetchCocktailByName(query: String) async throws -> [DrinkDetail]
    func fetchCocktailsByCategory(query: String) async throws -> [Drink]
    func fetchRandomDrink() async throws -> DrinkDetail
    func fetchAllIngredients() async throws -> [BasicIngredient]
    func fetchDrinksByIngredient(ingredient: String) async throws -> [Drink]
    func fetchIngredientByName(query: String) async throws -> IngredientDetail
}
