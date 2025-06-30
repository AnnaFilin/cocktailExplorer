//
//  IngredientDetailsViewModel.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 19/06/2025.
//

import Foundation

@MainActor
class IngredientDetailsViewModel: ObservableObject {
    private let ingredientsService: CocktailServiceProtocol
    
    @Published var detailedIngredients: [String: IngredientDetail] = [:]
    @Published var selectedIngredient: IngredientDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init(service: CocktailServiceProtocol) {
        self.ingredientsService = service
    }
    
    func loadIngredientDetails(_ ingredientName: String) async {
        if detailedIngredients[ingredientName] != nil {
            selectedIngredient = detailedIngredients[ingredientName]
        }
        isLoading = true
        errorMessage = nil
        do {
            let ingredientDetails = try await ingredientsService.fetchIngredientByName(query: ingredientName)
            detailedIngredients[ingredientName] = ingredientDetails
            selectedIngredient = ingredientDetails
        } catch {
            errorMessage = error.localizedDescription   
        }
        isLoading = false
    }
}

extension IngredientDetailsViewModel {
    static var preview: IngredientDetailsViewModel {
        IngredientDetailsViewModel(service: CocktailService())
    }
}
