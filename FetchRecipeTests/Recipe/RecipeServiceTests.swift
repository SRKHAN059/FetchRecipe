//
//  RecipeServiceTests.swift
//  FetchRecipeTests
//
//  Created by Shifath Khan on 1/29/25.
//

import XCTest
@testable import FetchRecipe

class RecipeServiceTests: XCTestCase {
    var mockNetworkClient: MockNetworkClient!
    var sut: RecipeService!
    
    override func setUp() {
        super.setUp()
        self.mockNetworkClient = MockNetworkClient()
        self.sut = RecipeService(networkClient: mockNetworkClient)
    }
    
    override func tearDown() {
        self.mockNetworkClient = nil
        self.sut = nil
        super.tearDown()
    }
    
    func testGetRecipesSuccess() async throws {
        let mockRecipe = RecipeModel(uuid: "test-uuid",
                                     cuisine: "test-cuisine",
                                     name: "test-name",
                                     photoUrlLarge: "https://dummyImage.com/large.png",
                                     photoUrlSmall: "https://dummyImage.com/small.png",
                                     sourceUrl: "https://dummyImage.com/",
                                     youtubeUrl: "https://youtube.com/")
        
        let mockResponse = GetRecipesResponse(recipes: [mockRecipe])
        self.mockNetworkClient.mockData = try JSONEncoder().encode(mockResponse)
        
        let response = try await self.sut.getReceipes(from: .all)
        XCTAssertEqual(response.recipes.count, 1)
        XCTAssertEqual(response.recipes.first?.uuid, "test-uuid")
        XCTAssertEqual(response.recipes.first?.cuisine, "test-cuisine")
        XCTAssertEqual(response.recipes.first?.name, "test-name")
    }
    
    func testGetRecipesFailure() async throws {
        self.mockNetworkClient.mockError = URLError(.unknown)
        
        do {
            let _ = try await self.sut.getReceipes(from: .all)
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}
