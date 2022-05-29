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
    
    var favouriteMode: Bool = false
    @State private var searchQuery: String = ""
    
    // Search Bar
    var body: some View {
        ScrollView (.vertical) {
            VStack (alignment: .leading) {
                SearchBar(text: self.$searchQuery)
                
                ForEach(self.recipeList.filter({searchQuery.isEmpty ? true : $0.name!.localizedCaseInsensitiveContains(self.searchQuery)}), id: \.self) { recipe in
                    ZStack (alignment: .topTrailing) {
                        Image("recipePlaceholder")
                             .resizable()
                             .aspectRatio(contentMode: .fill)
                             .frame(height: 150.0, alignment: .center)
                             .clipped()
                        Rectangle()
                            .fill(.black)
                            .frame(height: 150.0)
                             .mask(
                                LinearGradient(gradient: Gradient(colors: [.black.opacity(0), .black.opacity(0), .black.opacity(0), .red]), startPoint: .top, endPoint: .bottom)
                             )
                            .clipped()
                        VStack (alignment: .trailing) {
                            Text("Breakfast")
                                .padding([.top, .trailing], 15)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        VStack (alignment: .leading) {
                            Text("Apple Pie")
                                .padding(EdgeInsets(top: 120, leading: 15, bottom: 0, trailing: 0))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .shadow(radius: 2)
                            Image(systemName: "suit.heart")
                                .resizable()
                                .foregroundColor(.primary)
                                .frame(width: 32, height: 28)
                        }
                        .frame(width: 60, height: 60, alignment: .bottomTrailing)
                        .offset(x: -15, y: 80)
                    }
                }
                
                Spacer()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(favouriteMode: false)
    }
}
