//
//  FavoriteDrinksViewModel.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 18/06/2025.
//

import Foundation

@MainActor
class FavoriteDrinksViewModel: ObservableObject {
    private let drinkService: CocktailServiceProtocol
    
    @Published var favoriteDrinks: [DrinkDetail] = []
    @Published var selectedIngredient: String? = nil
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var ingredientFrequency: [String: Int] = [:]
    
    private var initialIDs: Set<String> = []
    
    private let key = "FavoriteDrinksDetails"
    
    init(service: CocktailServiceProtocol, initialIDs: Set<String> = []) {
        self.drinkService = service
        self.initialIDs = initialIDs
        Task {
            await self.setupFavorites()
        }
    }
    
    func recalculateIngredientFrequency() {
        ingredientFrequency = [:]
        for drink in favoriteDrinks {
            updateIngredientFrequency(drink: drink, isAdding: true)
        }
    }
    
    func updateIngredientFrequency(drink: DrinkDetail, isAdding: Bool) {
        
        for ingredient in drink.ingredients {
            if isAdding {
                ingredientFrequency[ingredient.name, default: 0] += 1
            } else {
                if let count = ingredientFrequency[ingredient.name], count <= 1 {
                    ingredientFrequency[ingredient.name] = nil
                } else if let count = ingredientFrequency[ingredient.name] {
                    ingredientFrequency[ingredient.name] = count - 1
                }
            }
        }
    }
    
    func setupFavorites() async {
        
        self.loadFavoriteDrinks()
        
        if self.favoriteDrinks.isEmpty && !initialIDs.isEmpty {
            await initializeFromIDs(initialIDs)
            save() 
        }
    }
    
    func initializeFromIDs(_ ids: Set<String>) async {
        var loadedDrinks: [DrinkDetail] = []
        
        do {
            for id in ids {
                let drink = try await drinkService.fetchCocktailById(drinkId: id)
                loadedDrinks.removeAll { $0.id == drink.id }
                loadedDrinks.append(drink)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        
        await MainActor.run {
            self.favoriteDrinks = loadedDrinks
        }
        recalculateIngredientFrequency()
    }
    
    
    private func loadFavoriteDrinks() {
        if let savedItems = UserDefaults.standard.data(forKey: key) {
            if let decodedItems = try? JSONDecoder().decode([DrinkDetail].self, from: savedItems) {
                
                favoriteDrinks = decodedItems
                return
            }
        }
        favoriteDrinks = []
    }
    
    func containsDrink(_ drinkId: String) -> Bool {
        favoriteDrinks.contains{ $0.id == drinkId }
    }
    
    func addDrink(_ drink: DrinkDetail) {
        favoriteDrinks.removeAll { $0.id == drink.id }
        favoriteDrinks.append(drink)
        updateIngredientFrequency(drink: drink, isAdding: true)
        save()
    }
    
    func removeDrink(_ drink: DrinkDetail) {
        favoriteDrinks.removeAll { $0.id == drink.id }
        updateIngredientFrequency(drink: drink, isAdding: false)
        save()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(favoriteDrinks) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}

extension FavoriteDrinksViewModel {
    static var preview: FavoriteDrinksViewModel {
        FavoriteDrinksViewModel(service: CocktailService())
    }
}
