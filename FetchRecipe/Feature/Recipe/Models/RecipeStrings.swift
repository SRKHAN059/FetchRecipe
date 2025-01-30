//
//  RecipeStrings.swift
//  FetchRecipe
//
//  Created by Shifath Khan on 1/28/25.
//

import Foundation

struct RecipeStrings {
    static var noRecipes: String {
        String(localized: "No Recipes To Display", comment: "Info text displayed when no recipes are found")
    }
    
    static var pullToRefreshList: String {
        String(localized: "Pull down to refresh recipes", comment: "Action text to pull to refresh")
    }
    
    static var viewYouTubeVideo: String {
        String(localized: "Watch recipe video on YouTube", comment: "Hyperlink text to indicate user can redirect to the video")
    }
    
    static var viewSource: String {
        String(localized: "Open original recipe website", comment: "Hyperlink text to indicate user can redirect to the respective recipe site")
    }
    
    static var fetchRecipesErrorMessage: String {
        String(localized: "Error fetching recipes. Please try again.", comment: "Error message displayed when fetching recipes fails")
    }
    
    static var ok: String {
        String(localized: "OK", comment: "button text acknowledging the modal")
    }
}
