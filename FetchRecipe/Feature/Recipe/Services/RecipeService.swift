//
//  RecipeService.swift
//  FetchRecipe
//
//  Created by Shifath Khan on 1/27/25.
//

import Foundation

protocol RecipeServiceProtocol {
    func getReceipes(from source: RecipesSource) async throws -> GetRecipesResponse
}

class RecipeService: NSObject, RecipeServiceProtocol {
    private let networkClient: RecipeDataFetchingProtocol
    
    init(networkClient: RecipeDataFetchingProtocol = RecipeDataFetchingClient()) {
        self.networkClient = networkClient
    }
    
    func getReceipes(from source: RecipesSource) async throws -> GetRecipesResponse {
        guard let url = URL(string: source.urlString) else {
            throw URLError(.badURL)
        }
        
        let data = try await self.networkClient.fetchData(from: url)
        return try JSONDecoder().decode(GetRecipesResponse.self, from: data)
    }
}
