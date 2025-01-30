//
//  RecipeDataFetchingClient.swift
//  FetchRecipe
//
//  Created by Shifath Khan on 1/29/25.
//

import Foundation

protocol RecipeDataFetchingProtocol {
    func fetchData(from url: URL) async throws -> Data
}

class RecipeDataFetchingClient: RecipeDataFetchingProtocol {
    func fetchData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
