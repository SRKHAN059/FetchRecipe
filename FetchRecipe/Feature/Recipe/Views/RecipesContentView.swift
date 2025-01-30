//
//  RecipesContentView.swift
//  FetchRecipe
//
//  Created by Shifath Khan on 1/28/25.
//

import Foundation
import SwiftUI

struct RecipesContentView: View {
    let recipeItem: RecipeModel
    let imageSize: CGFloat = 140
    
    @State private var image: UIImage?
    
    var body: some View {
        VStack(alignment: .leading, spacing: Padding.large.rawValue) {
            HStack {
                Spacer()
                
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: self.imageSize, height: self.imageSize)
                        .cornerRadius(8)
                } else {
                    ProgressView()
                        .frame(width: self.imageSize, height: self.imageSize)
                        .task {
                            image = try? await ImageDownloader.shared.getLargeImage(for: recipeItem)
                        }
                }
                
                Spacer()
            }
            
            if let sourceUrl = recipeItem.sourceUrl {
                let link = "[\(RecipeStrings.viewSource)](\(sourceUrl))"
                Text(.init(link))
                    .font(.footnote)
                    .fontWeight(.medium)
            }
            
            if let youTubeUrl = recipeItem.youtubeUrl {
                let link = "[\(RecipeStrings.viewYouTubeVideo)](\(youTubeUrl))"
                Text(.init(link))
                    .font(.footnote)
                    .fontWeight(.medium)
            }
        }
        .padding(.all, .large)
    }
}
