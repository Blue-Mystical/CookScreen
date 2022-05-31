//
//  RecipeListView.swift
//  CookScreen
//
//  Created by Blue Snow on 25/4/2565 BE.
//

import SwiftUI
import CoreData

struct RecipeListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: Recipe.getAllRecipes()) var recipeList:FetchedResults<Recipe>
    
    @State var favouriteMode: Bool = false
    @State var categoryFilter: String = ""
    @State private var searchQuery: String = ""
    
    @State public var navDesc: Bool = false
    @State var selectedRecipe: UUID = UUID()
    
    func getItem(with id: UUID?) -> Recipe? {
        guard let id = id else { return nil }
        let request = Recipe.fetchRequest() as! NSFetchRequest<Recipe>
        request.predicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)
        guard let items = try? managedObjectContext.fetch(request) else { return nil }
        return items.first
    }
    
    // Search Bar
    var body: some View {
        NavigationView {
            ScrollView (.vertical) {
                VStack (alignment: .leading) {
                    NavigationLink(destination: RecipeDescView(recipe: getItem(with: selectedRecipe), navDesc: $navDesc), isActive: $navDesc) { EmptyView() }
                    HStack {
                        SearchBar(text: self.$searchQuery)
                        Button {
                            favouriteMode.toggle()
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: 40, height: 40)
                                    .shadow(radius: 2)
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .foregroundColor(.primary)
                                    .frame(width: 32, height: 32)
                            }
                        }
                    }.padding()
                    
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
//        .navigationBarTitle(categoryFilter, displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
