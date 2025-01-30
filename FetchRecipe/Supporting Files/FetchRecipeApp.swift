//
//  FetchRecipeApp.swift
//  FetchRecipe
//
//  Created by Shifath Khan on 1/27/25.
//

import SwiftUI

@main
struct FetchRecipeApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            RecipesListView()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                ImageDownloader.shared.cleanup()
            }
        }
    }
}
