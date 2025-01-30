//
//  RecipesSource.swift
//  FetchRecipe
//
//  Created by Shifath Khan on 1/28/25.
//

import Foundation

enum RecipesSource: CaseIterable {
    case all
    case malformed
    case empty
    
    var urlString: String {
        switch self {
        case .all:
            return RecipeUrlConstants.allRecipesUrl
        case .malformed:
            return RecipeUrlConstants.malformedRecipesUrl
        case .empty:
            return RecipeUrlConstants.emptyRecipesUrl
        }
    }
    
    var displayName: String {
        switch self {
        case .all:
            return "All Recipes"
        case .malformed:
            return "Malformed Recipes"
        case .empty:
            return "Empty List"
        }
    }
}
