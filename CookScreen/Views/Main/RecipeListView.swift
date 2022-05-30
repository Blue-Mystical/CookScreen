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
    @State private var searchQuery: String = ""
    
    @State public var navDesc: Bool = false
    @State var selectedRecipe: UUID = UUID()
    
    // Search Bar
    var body: some View {
        NavigationView {
            ScrollView (.vertical) {
                VStack (alignment: .leading) {
                    NavigationLink(destination: RecipeDescView(selectedRecipe: selectedRecipe), isActive: $navDesc) { EmptyView() }
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
                        {(searchQuery.isEmpty ? true : $0.name!.localizedCaseInsensitiveContains(self.searchQuery)) &&
                            (favouriteMode == false ? true : $0.favourited == true)
                        }), id: \.self) { recipe in
                        RecipeRowView(name: recipe.name!, category: recipe.category!, image: recipe.image ?? .init(count: 0), favourited: recipe.favourited, itemID: recipe.id!, navDesc: $navDesc, selectID: $selectedRecipe)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
