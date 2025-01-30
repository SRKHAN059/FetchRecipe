//
//  GetRecipesResponse.swift
//  FetchRecipe
//
//  Created by Shifath Khan on 1/27/25.
//

import Foundation

class GetRecipesResponse: Codable {
    var recipes: [RecipeModel]
    
    init(recipes: [RecipeModel] = []) {
        self.recipes = recipes
    }
}
