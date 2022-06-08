//
//  ShoppingListView.swift
//  CookScreen
//
//  Created by Blue Snow on 30/5/2565 BE.
//

import SwiftUI
import CoreData

struct ShoppingListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: ShoppingItem.getAllShopItems()) var itemList:FetchedResults<ShoppingItem>
    
    @State private var itemField: String = ""
    
    var body: some View {
        ZStack {
            Color.ui.cream3
                .ignoresSafeArea()
            VStack {
                HStack {
                    TextField("Add item", text: self.$itemField)
                        .textFieldStyle(.roundedBorder)
                    // add new item
                    Button {
                        let newItem = ShoppingItem(context: self.managedObjectContext)
                        newItem.name = self.itemField
                        newItem.dateAdded = Date()
                        
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                        
                        self.itemField = ""
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundColor(Color.ui.cream5)
                                .frame(width: 40, height: 40)
                                .shadow(radius: 2)
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 32, height: 32)
                        }
                    }

                }
                .padding()
                Text("Swipe left on an item to remove.")
                    .font(.system(size: 16, design: .default))
                    .foregroundColor(Color.ui.white)
                    .padding([.bottom], 5)
                // Get items
                List {
                    ForEach(self.itemList) { item in
                        ShoppingRowView(name: item.name!)
                    }
                    .onDelete { indexSet in
                        // Deletes item be swiping left and press "Delete"
                        let deleteItem = self.itemList[indexSet.first!]
                        self.managedObjectContext.delete(deleteItem)
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                    }
                }
                .background(Color.ui.cream1)
                .onAppear { // Allows to change background color of the list
                  UITableView.appearance().backgroundColor = .clear
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
