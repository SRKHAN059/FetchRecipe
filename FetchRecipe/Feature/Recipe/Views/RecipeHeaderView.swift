//
//  RecipeHeaderView.swift
//  FetchRecipe
//
//  Created by Shifath Khan on 1/28/25.
//

import Foundation
import SwiftUI

struct RecipeHeaderView: View {
    let recipe: RecipeModel
    @Binding var expanded: Bool
    
    @State private var image: UIImage?
    private let contentSize: CGFloat = 50
    
    var body: some View {
        HStack {
            if !self.expanded {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: self.contentSize, height: self.contentSize)
                        .cornerRadius(8)
                } else {
                    ProgressView()
                        .frame(width: self.contentSize, height: self.contentSize)
                        .task {
                            self.image = try? await ImageDownloader.shared.getSmallImage(for: recipe)
                        }
                }
                
            }
            
            VStack(alignment: .leading) {
                Text(self.recipe.name)
                    .font(.headline)
                
                Text(self.recipe.cuisine)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.gray)
            }
            
            Spacer()
        }
        .frame(height: self.contentSize)
        .animation(.easeInOut(duration: 0.3), value: self.expanded)
    }
}
