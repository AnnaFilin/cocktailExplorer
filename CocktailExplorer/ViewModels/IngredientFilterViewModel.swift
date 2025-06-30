//
//  IngredientFilterViewModel.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 11/06/2025.
//

import Foundation

@MainActor
class IngredientFilterViewModel: ObservableObject {
    private let ingredientsService: CocktailServiceProtocol
    
    @Published var ingredients: [BasicIngredient] = []
    @Published var selectedIngredients: Set<BasicIngredient> = []
    
    @Published var filteredDrinks: [Drink] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var drinksErrorMessage: String? = nil
    
    private var allDrinksCache: [String: [Drink]] = [:]
    
    @Published var searchText = ""
    
    var hasLoadedIngredients = false
    
    init(service: CocktailServiceProtocol) {
        self.ingredientsService = service
    }
    
    var filteredIngredients: [BasicIngredient] {
        if searchText.isEmpty { return [] }
        
        else {
            return ingredients.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
                && !selectedIngredients.contains($0)
            }
        }
    }
    
    func loadIngredients() async {
        guard !hasLoadedIngredients else { return }
        hasLoadedIngredients = true
        
        isLoading = true
        do {
            ingredients = try await ingredientsService.fetchAllIngredients()
            errorMessage=nil
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func containsIngredient(_ ingredient: BasicIngredient) -> Bool {
        selectedIngredients.contains(ingredient)
    }
    
    func toggleIngredient(_ ingredient: BasicIngredient) async {
        
        if selectedIngredients.contains(ingredient) {
            selectedIngredients.remove(ingredient)
        } else {
            selectedIngredients.insert(ingredient)
        }
        
        await  updateFilteredDrinks()
    }
    
    @MainActor
    func updateFilteredDrinks()async{
        var drinksByIngredient: [[Drink]] = []
        
        isLoading = true
        drinksErrorMessage = nil
        
        for ingredient in selectedIngredients {
            
            let drinks =  await loadDrinksByIngredient(ingredient: ingredient.name)
            drinksByIngredient.append(drinks)
        }
        
        let intersected = drinksByIngredient.reduce(drinksByIngredient.first ?? []) { result, next in
            
            result.filter { drink in
                next.contains(where: { $0.id == drink.id })
            }
        }
        self.searchText = ""
        self.filteredDrinks = intersected
        
        isLoading = false
    }
    
    func resetAll() async {
        selectedIngredients.removeAll()
        searchText = ""
        filteredDrinks = []
    }
    
    func loadDrinksByIngredient(ingredient: String) async -> [Drink] {
        isLoading = true
        
        if let cached = allDrinksCache[ingredient] {
            isLoading = false
            return cached
        }
        
        do {
            let drinks = try await ingredientsService.fetchDrinksByIngredient(ingredient: ingredient )
            allDrinksCache[ingredient] = drinks
            drinksErrorMessage=nil
            isLoading = false
            return drinks
        } catch {
            drinksErrorMessage = error.localizedDescription
            return []
        }
        
    }
}

extension IngredientFilterViewModel {
    static var preview: IngredientFilterViewModel {
        let vm = IngredientFilterViewModel(service: CocktailService())
        vm.ingredients = [
            BasicIngredient(name: "Rum"),
            BasicIngredient(name: "Gin")
        ]
        return vm
    }
}
