//
//  RecipeListView.swift
//  CookScreen
//
//  Created by Blue Snow on 25/4/2565 BE.
//

import SwiftUI
import CoreData

// The recipe list
struct RecipeListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: Recipe.getAllRecipes()) var recipeList:FetchedResults<Recipe>
    
    @State var favouriteMode: Bool = false
    @State var categoryFilter: String = ""
    @State private var searchQuery: String = ""
    
    @State public var navDesc: Bool = false
    @State var selectedRecipe: UUID = UUID()
    
    // Get recipe content before moving on to the description page by comparing UUID
    func getItem(with id: UUID?) -> Recipe? {
        guard let id = id else { return nil }
        let request = Recipe.fetchRequest() as! NSFetchRequest<Recipe>
        request.predicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)
        guard let items = try? managedObjectContext.fetch(request) else { return nil }
        return items.first
    }
    
    
    var body: some View {
        ZStack {
            Color.ui.cream1
                .ignoresSafeArea()
            ScrollView (.vertical) {
                VStack (alignment: .leading) {
                    // Link to Recipe Detail view
                    NavigationLink(destination: RecipeDescView(recipe: getItem(with: selectedRecipe), navDesc: $navDesc), isActive: $navDesc) { EmptyView() }
                    HStack {
                        //Display Search Bar
                        SearchBar(text: self.$searchQuery)
                        // Toggle favourite mode
                        Button {
                            favouriteMode.toggle()
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: 40, height: 40)
                                    .shadow(radius: 2)
                                Image(systemName: self.favouriteMode ? "suit.heart.fill" : "suit.heart")
                                    .resizable()
                                    .foregroundColor(self.favouriteMode ? Color.ui.pink : Color.ui.cream5)
                                    .frame(width: 22, height: 20)
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    // Recipe list itself. It will filter based on query if there's any, while also filter if the recipe has been favourited or not. Also if the list is displayed inside the categories tab, it will also filter to the chosen category too.
                    ForEach(self.recipeList.filter(
                        {
                            (searchQuery.isEmpty ? true : $0.name!.localizedCaseInsensitiveContains(self.searchQuery)) &&
                            (favouriteMode == false ? true : $0.favourited == true) &&
                            (categoryFilter.isEmpty ? true : $0.category == self.categoryFilter)
                        }), id: \.self) { recipe in
                        RecipeRowView(name: recipe.name!, category: recipe.category!, image: recipe.image ?? .init(count: 0), favourited: recipe.favourited, itemID: recipe.id!, navDesc: $navDesc, selectID: $selectedRecipe)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
