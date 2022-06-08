//
//  RecipeDescView.swift
//  CookScreen
//
//  Created by Blue Snow on 27/4/2565 BE.
//

import SwiftUI
import CoreData

// Recipe details, includes edit, delete and fav.
// Also I don't know how to even unwrap the Recipe variable properly
struct RecipeDescView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showingAlert: Bool = false
    @State private var showingNotice: Bool = false
    @State var recipe: Recipe?
    @Binding var navDesc: Bool
    
    @State private var noticeTitle = "Notice"
    @State private var noticeMessage = "A message."
    
    func FavouriteRecipe () {
        recipe?.favourited.toggle()
        print(recipe?.favourited ?? false)
        
        // I don't even know how unwrap value in swift
        // SwiftUI is being a jerk. If I don't show notice here the fav button won't update
        self.noticeMessage = "(Un)favourited the recipe."
        self.showingNotice = true
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }

    var body: some View {
        ZStack {
            Color.ui.cream1
                .ignoresSafeArea()
            ScrollView (.vertical) {
                    VStack {
                        Text(recipe?.name ?? "Recipe Name")
                            .font(.system(size: 32, weight: .bold, design: .default))
                        if recipe!.image?.count != 0 {
                            Image(uiImage: (UIImage(data: recipe?.image ?? .init(count: 0)) ?? UIImage(named: "") ?? UIImage(named: "recipePlaceholder"))!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300.0, height: 250.0, alignment: .center)
                                .clipped()
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.ui.cream5, lineWidth: 6))
                                .shadow(radius: 10)
                        } else {
                            // Use apple pie image as placeholder.
                            Image("recipePlaceholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300.0, height: 250.0, alignment: .center)
                                .clipped()
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.ui.cream5, lineWidth: 4))
                                .shadow(radius: 10)
                        }
                        HStack {
                            // Cooking time
                            VStack {
                                Image(systemName: "clock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                                Text(String(recipe?.cookingtime ?? 0) )
                                    .font(.system(size: 15, design: .default))
                                Text("MINS")
                                    .frame(maxWidth: .infinity)
                                    .font(.system(size: 15, weight: .bold, design: .default))
                            }
                            // Energy Yield
                            VStack {
                                Image(systemName: "bolt")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                                Text(String(recipe?.nutrition ?? 0) )
                                    .font(.system(size: 15, design: .default))
                                Text("CALS")
                                    .frame(maxWidth: .infinity)
                                    .font(.system(size: 15, weight: .bold, design: .default))
                            }
                            // Servings
                            VStack {
                                Image(systemName: "person")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                                Text(String(recipe?.yield ?? 0) )
                                    .font(.system(size: 15, design: .default))
                                Text("SERVINGS")
                                    .frame(maxWidth: .infinity)
                                    .font(.system(size: 15, weight: .bold, design: .default))
                            }
                        }
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                        VStack (alignment: .trailing) {
                            // 3 Options: Edit, Delete and Favourite
                            HStack {
                                Spacer()
                                // Editing function hasn't been implemented
//                                Button {
//                                    print("Edit mockups")
//                                } label: {
//                                    Image(systemName: "pencil")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 32, height: 32)
//                                        .padding([.leading], 5)
//                                }
                                // Delete recipe with confirmation
                                Button {
                                    
                                } label: {
                                    Image(systemName: "trash.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 32, height: 32)
                                        .padding([.leading], 5)
                                        .onTapGesture {
                                            self.showingAlert = true
                                        }.confirmationDialog("Sure?", isPresented: $showingAlert) {
                                            Button("Delete", role: .destructive) {
                                                managedObjectContext.delete(recipe!)
                                                do {
                                                    try self.managedObjectContext.save()
                                                } catch {
                                                    print(error)
                                                }
                                                
                                                self.navDesc.toggle()
                                            }
                                            Button("Cancel", role: .cancel) {}
                                        } message: {
                                            Text("Are you sure?")
                                        }
                                }
                                // Toggle favourite
                                Button {
                                    FavouriteRecipe()
                                } label: {
                                    Image(systemName: (recipe?.favourited ?? false) ? "suit.heart.fill" : "suit.heart")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 32, height: 32)
                                }
                                .padding([.trailing], 20)
                            }
                        }
                        // Recipe description
                        Text(recipe?.desc ?? "Description")
                            .font(.system(size: 20, design: .default))
                            .padding([.top], 10)
                        // Directions
                        VStack (alignment: .leading) {
                            Text("Directions")
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .padding([.top], 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(recipe?.directions ?? "Placeholder")
                                .font(.system(size: 20, design: .default))
                                .padding([.top], 3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        // Ingredients
                        .padding([.leading], 20)
                        VStack (alignment: .leading) {
                            Text("Ingredients")
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .padding([.top], 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(recipe?.ingredients ?? "Placeholder")
                                .font(.system(size: 20, design: .default))
                                .padding([.top], 3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding([.leading], 20)
                    }
                    .foregroundColor(Color.ui.cream5)
            }
            .alert(isPresented: $showingNotice) {
                Alert(title: Text(self.noticeTitle), message: Text(self.noticeMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}
