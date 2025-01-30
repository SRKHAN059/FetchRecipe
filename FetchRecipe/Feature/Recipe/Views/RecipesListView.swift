//
//  RecipesListView.swift
//  FetchRecipe
//
//  Created by Shifath Khan on 1/27/25.
//

import SwiftUI

struct RecipesListView: View {
    @StateObject private var viewModel: RecipesViewModel = .init()
    @State var optionToggle: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: Padding.standard.rawValue) {
                self.sourceOptionView
                
                if self.viewModel.recipes.isEmpty {
                    Text(RecipeStrings.noRecipes)
                        .font(.headline)
                        .fontWeight(.medium)
                    Text(RecipeStrings.pullToRefreshList)
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                } else {
                    self.listView
                }
            }
            .padding(.all, .zero)
        }
        .padding(.all, .large)
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .refreshable {
            await self.viewModel.fetchRecipes()
        }
        .alert(RecipeStrings.fetchRecipesErrorMessage, isPresented: self.$viewModel.shouldShowErrorAlert) {
            Button(RecipeStrings.ok) {
                self.viewModel.shouldShowErrorAlert = false
            }
        }
    }
    
    private var sourceOptionView: some View {
        VStack {
            DropdownStyleView(expanded: self.$optionToggle) {
                Button(action: {
                    self.optionToggle.toggle()
                }) {
                    HStack {
                        Text("Source: \(self.viewModel.source.displayName)")
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees(self.optionToggle ? 180 : 0))
                            .animation(.easeInOut(duration: 0.3), value: self.optionToggle)
                    }
                }
                .foregroundStyle(Color.black)
            } content: {
                // Content
                VStack(alignment: .leading, spacing: Padding.standard.rawValue) {
                    ForEach(RecipesSource.allCases, id: \.self) { source in
                        Button(action: {
                            self.viewModel.source = source
                            self.optionToggle.toggle()
                        }) {
                            Text(source.displayName)
                                .padding(.all, .small)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .foregroundStyle(Color.black)
                    }
                }
                .padding(.top, .large)
            }
        }
        .padding(.all, .large)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(16)
    }
    
    private var listView: some View {
        LazyVStack(alignment: .leading) {
            ForEach(self.viewModel.recipes, id: \.uuid) { recipe in
                let expanded = self.binding(for: recipe.uuid)
                DropdownStyleView(expanded: expanded){
                    Button(action: {
                        expanded.wrappedValue.toggle()
                    }) {
                        RecipeHeaderView(recipe: recipe, expanded: expanded)
                    }
                    .foregroundStyle(Color.black)
                } content: {
                    RecipesContentView(recipeItem: recipe)
                }
                                        
                Divider()
            }
        }
        .padding(.all, .large)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(16)
    }
    
    private func binding(for id: String) -> Binding<Bool> {
        .init {
            self.viewModel.expanded[id, default: false]
        } set: {
            self.viewModel.expanded[id] = $0
        }
    }
}


