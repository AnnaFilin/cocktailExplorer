//
//  CocktailExplorerApp.swift
//  CocktailExplorer
//
//  Created by Anna Filin on 02/06/2025.
//

import SwiftUI

@main
struct CocktailExplorerApp: App {
    @StateObject private var drinksViewModel = DrinksViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(drinksViewModel)
        }
    }
}
