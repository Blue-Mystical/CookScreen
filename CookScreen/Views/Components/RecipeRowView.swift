//
//  RecipeRowView.swift
//  CookScreen
//
//  Created by Blue Snow on 30/5/2565 BE.
//

import SwiftUI

// Single recipe Row, that changes tab to detail tab upon tapping on it using bindings

struct RecipeRowView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var name: String
    @State var category: String
    @State var image: Data = .init(count: 0)
    @State var favourited: Bool
    @State var itemID: UUID
    
    @Binding var navDesc: Bool
    @Binding var selectID: UUID
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            Button {
                navDesc = true
                selectID = itemID
            } label: {
                VStack {
                    ZStack (alignment: .topTrailing) {
                        // Shows image if the recipe has user-added image
                        if self.image.count != 0 {
                            Image(uiImage: UIImage(data: self.image)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 150.0, alignment: .center)
                                .clipped()
                        } else {
                            // placeholder if the user doesn't put any
                            Image("recipePlaceholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 150.0, alignment: .center)
                                .clipped()
                        }
                        
                        // Gradient shadow
                        Rectangle()
                            .fill(Color.ui.cream5)
                            .frame(height: 150.0)
                             .mask(
                                LinearGradient(gradient: Gradient(colors: [.black.opacity(0), .black.opacity(0), .black.opacity(0), .red]), startPoint: .top, endPoint: .bottom)
                             )
                            .clipped()
                        // Category
                        VStack (alignment: .trailing) {
                            Text(self.category)
                                .font(.system(size: 20, design: .default))
                                .padding([.top, .trailing], 15)
                                .shadow(color: .black, radius: 5)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        // Name
                        VStack (alignment: .leading) {
                            Text(self.name)
                                .font(.system(size: 26, weight: .bold, design: .default))
                                .padding(EdgeInsets(top: 108, leading: 15, bottom: 0, trailing: 0))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
            
            // [UNUSED] favourite button, it doesn't update when the user taps on it
            
//                ZStack {
//                    Circle()
//                        .foregroundColor(.white)
//                        .frame(width: 60, height: 60)
//                        .shadow(radius: 2)
//                    VStack {
//                        Button {
//                            favourited.toggle()
//                            do {
//                                try self.managedObjectContext.save()
//                            } catch {
//                                print(error)
//                            }
//                        } label: {
//                            if favourited {
//                                Image(systemName: "suit.heart.fill")
//                                    .resizable()
//                                    .foregroundColor(.primary)
//                                    .frame(width: 32, height: 28)
//                            } else {
//                                Image(systemName: "suit.heart")
//                                    .resizable()
//                                    .foregroundColor(.primary)
//                                    .frame(width: 32, height: 28)
//                            }
//                        }
//                    }
//                }
//                .frame(width: 60, height: 60, alignment: .bottomTrailing)
//                .offset(x: -15, y: 80)
        }
        .foregroundColor(Color.ui.white)
    }
}

struct RecipeRowView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRowView(name: "Recipe Name", category: "Category", image: .init(count: 0), favourited: false, itemID: UUID(), navDesc: .constant(false), selectID: .constant(UUID()))
    }
}
