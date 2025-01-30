//
//  MockNetworkClient.swift
//  FetchRecipeTests
//
//  Created by Shifath Khan on 1/29/25.
//

import Foundation
@testable import FetchRecipe

class MockNetworkClient: RecipeDataFetchingProtocol {
    var mockData: Data?
    var mockError: Error?
    
    func fetchData(from url: URL) async throws -> Data {
        if let error = self.mockError {
            throw error
        }
        return self.mockData ?? Data()
    }
}
