//
//  DrinksViewModel.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 02/06/2025.
//

import Foundation
import Combine


@MainActor
class DrinksViewModel: ObservableObject {
    @Published var favoriteDrinkIDs: Set<String> = []
    
    private let key = "FavoriteDrinks"
    private var cancellables = Set<AnyCancellable>()

    
    @Published var drinks: [Drink] = []
    @Published var searchResults: [DrinkDetail] = []
    @Published var categoryResults: [Drink] = []
    @Published var isLoading: Bool = false
    @Published var searchErrorMessage: String? = nil
    @Published var allDrinksErrorMessage: String? = nil
    @Published var categoryDrinksErrorMessage: String? = nil

    @Published var randomErrorMessage: String? = nil
    @Published var currentErrorMessage: String? = nil
    @Published var categoryErrorMessage: String? = nil
    @Published var currentDrink: DrinkDetail? = nil
    @Published var randomDrink: DrinkDetail? = nil
    
    @Published var showOnlyFavorites: Bool = false

    @Published var searchText: String = ""
//    @Published var selectedCategory: String = "" {
//        didSet {
//            Task {
//                await pickRandomDrink(from: selectedCategory)
//            }
//        }
//    }
    @Published var selectedCategory: String? = nil {
        didSet {
            Task {
                if let category = selectedCategory {
                    await pickRandomDrink(from: category)
                }
            }
        }
    }

    
    @Published var selectedAlcoholFilter: AlcoholFilterOption? = nil

    @Published var filteredDrinks: [Drink] = []
    
    private let drinksService: CocktailServiceProtocol = CocktailService()
    
    var hasLoadedDrinks = false
    
    init() {
        loadFavorites()
        setupBindings()
    }
    
    private func setupBindings(){
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else {return}
                Task {
                    await self.loadDrinks(query: query)
                }
            }
            .store(in: &cancellables)
    }
    
    private func convertToPreview(_ details: [DrinkDetail]) -> [Drink] {
        return details.map{ Drink(id: $0.id, name: $0.name, thumbnail: $0.thumbnail)}
    }

    
    func updateFilteredDrinks() {
        let trimmedSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        let base: [Drink] = trimmedSearch.isEmpty
            ? drinks
            : convertToPreview(searchResults)
        
        if showOnlyFavorites {
            filteredDrinks = base.filter { favoriteDrinkIDs.contains($0.id) }
        } else if trimmedSearch.isEmpty {
            filteredDrinks = base 
        } else {
            filteredDrinks = base.filter {
                $0.name.lowercased().contains(trimmedSearch.lowercased())
            }
        }
    }
     
    func startLoadingDrinks() async {
        guard !hasLoadedDrinks else { return }
        hasLoadedDrinks = true
        
        isLoading = true
         do {
             drinks = try await drinksService.fetchCocktailsList()
             allDrinksErrorMessage=nil
             updateFilteredDrinks()
         } catch {
             allDrinksErrorMessage = error.localizedDescription
         }
         isLoading = false
    }
    
    func loadDrinkDetail(drinkId: String) async {

        isLoading = true
         do {
             currentDrink = try await drinksService.fetchCocktailById(drinkId: drinkId)
             currentErrorMessage = nil
         } catch {
             currentErrorMessage = error.localizedDescription
         }
         isLoading = false
    }
    
    func loadDrinks(query: String) async {
        isLoading = true
         do {
             searchResults = try await drinksService.fetchCocktailByName(query: query)
             searchErrorMessage = nil
         } catch {
             searchErrorMessage = error.localizedDescription
         }
         isLoading = false
    }
    
    func loadDrinksByCategory(query: String) async {
        isLoading = true
         do {
             categoryResults = try await drinksService.fetchCocktailsByCategory(query: query)
             categoryErrorMessage = nil
         } catch {
             categoryErrorMessage = error.localizedDescription
         }
//         isLoading = false
    }
    
    func pickRandomDrink(from category: String) async {
        await loadDrinksByCategory(query: category)
        
        guard !categoryResults.isEmpty else { return }
        let random = categoryResults.randomElement()
        
        do {
            if let id = random?.id {
                randomDrink = try await drinksService.fetchCocktailById(drinkId: id)
                currentErrorMessage = nil
            }
        } catch {
            currentErrorMessage = error.localizedDescription
        }
                 isLoading = false

    }

    
    func loadRandomDrink() async {
        isLoading = true
         do {
             randomDrink = try await drinksService.fetchRandomDrink()
             randomErrorMessage = nil
         } catch {
             randomErrorMessage = error.localizedDescription
         }
         isLoading = false
    }
    
    private func loadFavorites() {
        if let savedItems = UserDefaults.standard.data(forKey: key) {
            if let decodedItems = try? JSONDecoder().decode(Set<String>.self, from: savedItems) {
                
                favoriteDrinkIDs = decodedItems
                return
            }
        }
        
        favoriteDrinkIDs = []
    }
    
    func containsDrink(_ drinkId: String) -> Bool {
        favoriteDrinkIDs.contains(drinkId)
    }
    
    func addDrink(_ drinkId: String) {
        favoriteDrinkIDs.insert(drinkId)
        save()
    }
    
    func removeDrink(_ drinkId: String) {
        favoriteDrinkIDs.remove(drinkId)
        save()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(favoriteDrinkIDs) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}

extension DrinksViewModel {
    static var preview: DrinksViewModel {
        let vm = DrinksViewModel()
        vm.drinks = Drink.allDrinks
        vm.currentDrink = DrinkDetail.example
        vm.randomDrink = DrinkDetail.example
        return vm
    }
}
