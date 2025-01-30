//
//  ImageDownloaderTests.swift
//  FetchRecipeTests
//
//  Created by Shifath Khan on 1/29/25.
//

import XCTest
@testable import FetchRecipe

final class ImageDownloaderTests: XCTestCase {
    var sut: ImageDownloader!
    var mockRecipe: RecipeModel!
    
    override func setUp() {
        super.setUp()
        self.sut = ImageDownloader.shared
        self.mockRecipe = RecipeModel(uuid: "test-uuid",
                                      cuisine: "test-cuisine",
                                      name: "test-name",
                                      photoUrlLarge: "https://dummyImage.com/large.png",
                                      photoUrlSmall: "https://dummyImage.com/small.png",
                                      sourceUrl: "https://dummyImage.com/",
                                      youtubeUrl: "https://youtube.com/")
    }
    
    override func tearDown() {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let testPath = documentsPath.appendingPathComponent("test-uuid")
        try? FileManager.default.removeItem(at: testPath)
        self.mockRecipe = nil
        self.sut = nil
        super.tearDown()
    }
    
    func testLargeImageCached() async throws {
        let url = self.sut.createImageUrl(for: self.mockRecipe.uuid, isLarge: true)
        let image = UIImage(systemName: "birthday.cake")!
        try image.pngData()?.write(to: url)
        
        let actualImage = try await self.sut.getLargeImage(for: self.mockRecipe)
        XCTAssertNotNil(actualImage)
    }
    
    func testSmallImageCached() async throws {
        let url = self.sut.createImageUrl(for: self.mockRecipe.uuid, isLarge: false)
        let image = UIImage(systemName: "birthday.cake")!
        try image.pngData()?.write(to: url)
        
        let actualImage = try await self.sut.getSmallImage(for: self.mockRecipe)
        XCTAssertNotNil(actualImage)
    }
}
