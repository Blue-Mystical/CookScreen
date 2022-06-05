//
//  RecipeAddView.swift
//  CookScreen
//
//  Created by Blue Snow on 25/4/2565 BE.
//

import SwiftUI
import CoreData

// Tab used for adding a new recipe or editing an existing recipe. (the latter is not implemented)
struct RecipeAddEditView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: Category.getAllCategories()) var categoryList:FetchedResults<Category>
    
    var editingMode: Bool = false
    var recipeID: UUID = UUID()
    @State private var showingPopover: Bool = false
    @State private var showingAlert: Bool = false
    
    @State private var name: String = ""
    @State private var desc: String = ""
    @State var cookingtime: Int32 = 0
    @State private var directions: String = ""
    @State private var ingredients: String = ""
    @State private var nutrition: Int32 = 0
    @State private var yield: Int32 = 0
    @State var image: Data = .init(count: 0)
    
    @State var showImage: Bool = false
    
    @State private var selectedCategory = "Unknown"
    
    @State private var alertTitle = "Notice"
    @State private var alertMessage = "A message."
    
    // Reset values after adding a new recipe
    func ResetValues() {
        name = ""
        desc = ""
        cookingtime = 0
        directions = ""
        ingredients = ""
        nutrition = 0
        yield = 0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Name")) {
                    TextField("Name", text: $name)
                }
                Section(header: Text("Category")) {
                    // Fetch categories the user created into the picker
                    VStack {
                        Picker("Category", selection: $selectedCategory) {
                            ForEach(categoryList, id: \.self) { (catitem: Category) in
                                Text(catitem.name!).tag(catitem.name!)
                            }
                        }
                    }
                }
                Section(header: Text("Description")) {
                    TextEditor(text: $desc)
                }
                Section(header: Text("Cooking Time (in minutes)")) {
                    // Limits the field to accept only number and to prevent nil values
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
                Section(header: Text("Nutrition (in calories)")) {
                    // Limits the field to accept only number and to prevent nil values
                    TextField("in calories", text: Binding(
                        get: { String(nutrition) },
                        set: { nutrition = Int32($0) ?? 0 }
                    ))
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Yield (in servings)")) {
                    // Limits the field to accept only number and to prevent nil values
                    TextField("in servings", text: Binding(
                        get: { String(yield) },
                        set: { yield = Int32($0) ?? 0 }
                    ))
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Image")) {
                    if self.image.count != 0 {
                        // Displays image when the user added it in
                        Button(action: {
                            self.showImage.toggle()
                        }) {
                            Image(uiImage: UIImage(data: self.image)!)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150, alignment: .center)
                            .cornerRadius(12)
                        }
                    } else {
                        // Shows an icon when the user hasn't add an image yet
                        Button(action: {
                            self.showImage.toggle()
                        }) {
                            Image(systemName: "photo.fill")
                                .font(.system(size: 60))
                                .frame(width: 100, height: 100, alignment: .center)
                        }
                    }
                }
                Section {
                    // Do the add recipe function
                    Button("Add Recipe") {
                        // recipe name and category must not be empty
                        if self.name == "" {
                            self.alertTitle = "Warning"
                            self.alertMessage = "Please add a recipe name."
                            self.showingAlert = true
                        } else if self.selectedCategory == "" || self.selectedCategory == "Unknown" {
                            self.alertTitle = "Warning"
                            self.alertMessage = "Please add a category."
                            self.showingAlert = true
                        }
                        else {
                            // Create object and save
                            let newRecipe = Recipe(context: managedObjectContext)
                            newRecipe.id = UUID()
                            newRecipe.name = self.name
                            newRecipe.dateadded = Date()
                            newRecipe.category = self.selectedCategory
                            newRecipe.desc = self.desc
                            newRecipe.cookingtime = self.cookingtime
                            newRecipe.directions = self.directions
                            newRecipe.ingredients = self.ingredients
                            newRecipe.nutrition = self.nutrition
                            newRecipe.yield = self.yield
                            newRecipe.image = self.image
                            newRecipe.favourited = false
                            
                            print(newRecipe)
                            
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                            print("Save completed")
                            self.alertMessage = "Successfully added a recipe."
                            self.showingAlert = true
                            ResetValues()
                            
                        }
                    }
                }
            }
            .sheet(isPresented: self.$showImage, content: {
                ImagePicker(showImage: self.$showImage, image: self.$image)
            })
            .navigationTitle("Add Recipe")
        }
        .navigationBarTitle("", displayMode: .inline)
        // in-view alert box with custom texts
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct RecipeAddEditView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeAddEditView(editingMode: false, recipeID: UUID())
    }
}
