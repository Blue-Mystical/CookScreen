//
//  CategoryListView.swift
//  CookScreen
//
//  Created by Blue Snow on 27/4/2565 BE.
//

import SwiftUI
import CoreData

// Lists categories and lets the user find recipes based on a chosen category
struct CategoryListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: Category.getAllCategories()) var categoryList:FetchedResults<Category>
    
    @State private var categoryField: String = ""
    
    @State var categoryFilter: String = ""
    @State public var navFilteredList: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: RecipeListView(categoryFilter: self.categoryFilter), isActive: $navFilteredList) { EmptyView() }
                HStack {
                    TextField("Add category", text: self.$categoryField)
                        .textFieldStyle(.roundedBorder)
                    // add new category
                    Button {
                        let newItem = Category(context: self.managedObjectContext)
                        newItem.name = self.categoryField
                        newItem.dateAdded = Date()
                        
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                        
                        self.categoryField = ""
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

                }
                .padding()
                // Show categories
                List {
                    ForEach(self.categoryList) { item in
                        CategoryRowView(name: item.name!, navFilteredList: $navFilteredList, selectCategory: $categoryFilter)
                    }.onDelete { indexSet in
                        // Deletes category be swiping left and press "Delete"
                        let deleteItem = self.categoryList[indexSet.first!]
                        self.managedObjectContext.delete(deleteItem)
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
