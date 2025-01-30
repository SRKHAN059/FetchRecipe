//
//  MockRecipeService.swift
//  FetchRecipeTests
//
//  Created by Shifath Khan on 1/29/25.
//

import Foundation
@testable import FetchRecipe

class MockRecipeService: RecipeServiceProtocol {
    var mockResponse: GetRecipesResponse?
    var mockError: Error?
    
    func getReceipes(from source: RecipesSource) async throws -> GetRecipesResponse {
        if let error = self.mockError {
            throw error
        }
        
        guard let response = self.mockResponse else {
            throw URLError(.unknown)
        }
        
        return response
    }
}
