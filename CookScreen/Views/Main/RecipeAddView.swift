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
    
    @FetchRequest(fetchRequest: Category.getAllCategories()) var categoryList:FetchedResults<Category>
    
    var editingMode: Bool = false
    var recipeID: UUID = UUID()
    @State private var showingPopover: Bool = false
    
    @State private var name: String = ""
//    @State private var category: [String] = []
    
//    @State private var selectedCategories: [String] = []
    @State private var desc: String = ""
    @State var cookingtime: Int32 = 0
    @State private var directions: String = ""
    @State private var ingredients: String = ""
    @State private var nutrition: Int32 = 0
    @State private var yield: Int32 = 0
    @State var image: Data = .init(count: 0)
    
    @State var showImage: Bool = false
    
    @State private var selectedName = "Unknown"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Name")) {
                    TextField("Name", text: $name)
                }
                Section(header: Text("Category")) {
                    
                    VStack {
                        Picker("Category", selection: $selectedName) {
                            ForEach(categoryList, id: \.self) { (catitem: Category) in
                                Text(catitem.name!).tag(catitem.name!)
                            }
                        }
                    }
//                    Picker
//                    Button(action: {
//                        showingPopover.toggle()
//                    }) {
//                        HStack {
//                            Spacer()
//                            Image(systemName: "chevron.right")
//                                .font(.caption)
//                        }
//                    }
//                    .popover(isPresented: $showingPopover) {
//                        CategoryPickerView(categoryList: self.category, selectedCategories: $selectedCategories)
//                    }
                }
                Section(header: Text("Description")) {
                    TextEditor(text: $desc)
                }
                Section(header: Text("Cooking Time")) {
                    TextField("in minutes", text: Binding(
                        get: { String(cookingtime) },
                        set: { cookingtime = Int32($0) ?? 0 }
                    ))
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Directions")) {
                    TextEditor(text: $directions)
                }
                Section(header: Text("Ingredients")) {
                    TextEditor(text: $ingredients)
                }
                Section(header: Text("Nutrition")) {
                    TextField("in calories", text: Binding(
                        get: { String(nutrition) },
                        set: { nutrition = Int32($0) ?? 0 }
                    ))
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Yield")) {
                    TextField("in servings", text: Binding(
                        get: { String(yield) },
                        set: { yield = Int32($0) ?? 0 }
                    ))
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Image")) {
                    if self.image.count != 0 {
                        Button(action: {
                            self.showImage.toggle()
                        }) {
                            Image(uiImage: UIImage(data: self.image)!)
                        }
                    } else {
                        Button(action: {
                            self.showImage.toggle()
                        }) {
                            Image(systemName: "photo.fill")
                                .font(.system(size: 60))
                        }
                    }
                }
                Section {
                    Button("Add Recipe") {
//                        let newRecipe
                    }
                }
            }
            .navigationTitle("Add Recipe")
        }
    }
}

struct RecipeAddView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeAddView(editingMode: false, recipeID: UUID())
    }
}
