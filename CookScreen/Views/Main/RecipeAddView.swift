//
//  RecipeAddView.swift
//  CookScreen
//
//  Created by Blue Snow on 25/4/2565 BE.
//

import SwiftUI
import CoreData

struct RecipeAddView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var name: String = ""
    @State private var category: String = ""
    @State private var desc: String = ""
    @State private var cookingtime: Int32 = 0
    @State private var directions: String = ""
    @State private var description: String = ""
    @State private var ingredients: String = ""
    @State private var nutrition: Int32 = 0
    @State private var yield: Int32 = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Recipe Name", text: $name)
                }
            }
            .navigationTitle("Add Recipe")
        }
    }
}

struct RecipeAddView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeAddView()
    }
}
