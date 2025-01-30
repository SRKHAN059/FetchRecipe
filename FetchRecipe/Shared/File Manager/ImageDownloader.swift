//
//  ImageDownloader.swift
//  FetchRecipe
//
//  Created by Shifath Khan on 1/27/25.
//

import SwiftUI
import Foundation

class ImageDownloader {
    static let shared = ImageDownloader()
    private let parentDirectory: URL
    
    private init() {
        self.parentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // MARK: - Public
    
    func getLargeImage(for recipeItem: RecipeModel) async throws -> UIImage? {
        return try await getImage(for: recipeItem, isLarge: true)
    }
    
    func getSmallImage(for recipeItem: RecipeModel) async throws -> UIImage? {
        return try await getImage(for: recipeItem, isLarge: false)
    }
    
    
    // MARK: - Private
    
    private func getImage(for recipeItem: RecipeModel, isLarge: Bool) async throws -> UIImage? {
        if self.existsInCache(for: recipeItem.uuid, isLarge: isLarge) {
            return self.getStoredImage(for: recipeItem, isLarge: isLarge)
        } else {
            guard let urlString = isLarge ? recipeItem.photoUrlLarge : recipeItem.photoUrlSmall,
                    let imageUrl = URL(string: urlString) else { return nil }
            
            let (data, _) = try await URLSession.shared.data(from: imageUrl)
            guard let image = UIImage(data: data) else {
                throw NSError()
            }
            
            let url = self.createImageUrl(for: recipeItem.uuid, isLarge: isLarge)
            try data.write(to: url)
            return image
        }
    }
    
    private func getStoredImage(for recipeItem: RecipeModel, isLarge: Bool) -> UIImage? {
        let url = self.createImageUrl(for: recipeItem.uuid, isLarge: isLarge)
        guard let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else { return nil }
        return image
    }
    
    // MARK: - URL/Directory
    
    func existsInCache(for id: String, isLarge: Bool) -> Bool {
        let path = self.createImageUrl(for: id, isLarge: isLarge).path
        return FileManager.default.fileExists(atPath: path)
    }
    
    func createImageUrl(for id: String, isLarge: Bool) -> URL {
        let sizeFolder = isLarge ? "large" : "small"
        let dirUrl = self.parentDirectory.appendingPathComponent(id, isDirectory: true)
        try? self.createDirectoryIfNeeded(folderUrl: dirUrl) // assume directory created otherwise
        return dirUrl.appendingPathComponent(sizeFolder)
    }
    
    func createDirectoryIfNeeded(folderUrl: URL) throws {
        var isDirectory = ObjCBool(true)
        guard !FileManager.default.fileExists(atPath: folderUrl.path, isDirectory: &isDirectory) else { return }
        
        try FileManager.default.createDirectory(atPath: folderUrl.path, withIntermediateDirectories: true, attributes: [:])
    }
}
