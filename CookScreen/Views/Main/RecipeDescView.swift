//
//  RecipeDescView.swift
//  CookScreen
//
//  Created by Blue Snow on 27/4/2565 BE.
//

import SwiftUI
import CoreData

struct RecipeDescView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var recipe: Recipe?

    var body: some View {
        ScrollView (.vertical) {
            VStack {
                Text(recipe?.name ?? "Recipe Name")
                if recipe!.image?.count != 0 {
                    Image(uiImage: (UIImage(data: recipe?.image ?? .init(count: 0)) ?? UIImage(named: "") ?? UIImage(named: "recipePlaceholder"))!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300.0, height: 250.0, alignment: .center)
                        .clipped()
                } else {
                    Image("recipePlaceholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300.0, height: 250.0, alignment: .center)
                        .clipped()
                }
                HStack {
                    VStack {
                        Image(systemName: "clock")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text(String(recipe?.cookingtime ?? 0) )
                        Text("MINS")
                            .frame(maxWidth: .infinity)
                    }
                    VStack {
                        Image(systemName: "bolt")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text(String(recipe?.cookingtime ?? 0) )
                        Text("CALS")
                            .frame(maxWidth: .infinity)
                    }
                    VStack {
                        Image(systemName: "clock")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text(String(recipe?.cookingtime ?? 0) )
                        Text("SERVINGS")
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                VStack (alignment: .trailing) {
                    HStack {
                        Spacer()
                        Button {
                            print("Edit mockups")
                        } label: {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                        }
                        Button {
                            print("Delete")
                        } label: {
                            Image(systemName: "trash.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                        }
                        Button {
                            recipe?.favourited.toggle()
                            print(recipe?.favourited ?? false)
                            
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                            
                        } label: {
                            Image(systemName: (recipe?.favourited ?? false) ? "suit.heart.fill" : "suit.heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                        }
                        .padding([.trailing], 14)
                    }
                }
                Text(recipe?.desc ?? "Description")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}

