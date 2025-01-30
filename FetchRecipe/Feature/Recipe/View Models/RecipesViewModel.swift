//
//  RecipesViewModel.swift
//  FetchRecipe
//
//  Created by Shifath Khan on 1/27/25.
//

import Foundation

@MainActor
class RecipesViewModel: ObservableObject {
    @Published var recipes: [RecipeModel] = []
    @Published var shouldShowErrorAlert: Bool = false
    @Published var expanded: [String: Bool] = [:]
    
    var source: RecipesSource = .all
    private let service: RecipeServiceProtocol
        
    init(service: RecipeServiceProtocol = RecipeService()) {
        self.service = service
    }
    
    func clearModel() {
        self.recipes.removeAll()
        self.expanded.removeAll()
    }
    
    func fetchRecipes() async {
        do {
            let response = try await self.service.getReceipes(from: self.source)
            self.recipes = response.recipes
            self.expanded = Dictionary(uniqueKeysWithValues: recipes.map { ($0.uuid, false) })
        } catch {
            self.clearModel()
            self.shouldShowErrorAlert = true
        }
    }
}
