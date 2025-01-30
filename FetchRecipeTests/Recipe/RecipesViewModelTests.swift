//
//  RecipesViewModelTests.swift
//  FetchRecipeTests
//
//  Created by Shifath Khan on 1/29/25.
//

import XCTest
@testable import FetchRecipe

@MainActor
class RecipesViewModelTests: XCTestCase {
    var mockService: MockRecipeService!
    var sut: RecipesViewModel!
    
    override func setUp() {
        super.setUp()
        self.mockService = MockRecipeService()
        self.sut = RecipesViewModel(service: self.mockService)
    }
    
    override func tearDown() {
        self.mockService = nil
        self.sut = nil
        super.tearDown()
    }
    
    func testFetchRecipesSuccess() async {
        let mockRecipe = RecipeModel(uuid: "test-uuid",
                                     cuisine: "test-cuisine",
                                     name: "test-name",
                                     photoUrlLarge: "https://dummyImage.com/large.png",
                                     photoUrlSmall: "https://dummyImage.com/small.png",
                                     sourceUrl: "https://dummyImage.com/",
                                     youtubeUrl: "https://youtube.com/")
        let mockResponse = GetRecipesResponse(recipes: [mockRecipe])
        self.mockService.mockResponse = mockResponse
        
        await self.sut.fetchRecipes()
        XCTAssertEqual(self.sut.recipes.count, 1)
        XCTAssertEqual(self.sut.recipes.first?.uuid, "test-uuid")
        XCTAssertEqual(self.sut.recipes.first?.cuisine, "test-cuisine")
        XCTAssertEqual(self.sut.recipes.first?.name, "test-name")
        XCTAssertFalse(self.sut.shouldShowErrorAlert)
    }
    
    func testFetchRecipesFailure() async {
        self.mockService.mockError = URLError(.notConnectedToInternet)
        
        await self.sut.fetchRecipes()
        XCTAssertTrue(self.sut.recipes.isEmpty)
        XCTAssertTrue(self.sut.shouldShowErrorAlert)
    }
}
