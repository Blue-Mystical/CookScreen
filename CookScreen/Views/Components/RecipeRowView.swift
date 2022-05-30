//
//  RecipeRowView.swift
//  CookScreen
//
//  Created by Blue Snow on 30/5/2565 BE.
//

import SwiftUI

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
                        if self.image.count != 0 {
                            Image(uiImage: UIImage(data: self.image)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 150.0, alignment: .center)
                                .clipped()
                        } else {
                            Image("recipePlaceholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 150.0, alignment: .center)
                                .clipped()
                        }
                        
                        Rectangle()
                            .fill(.black)
                            .frame(height: 150.0)
                             .mask(
                                LinearGradient(gradient: Gradient(colors: [.black.opacity(0), .black.opacity(0), .black.opacity(0), .red]), startPoint: .top, endPoint: .bottom)
                             )
                            .clipped()
                        VStack (alignment: .trailing) {
                            Text(self.category)
                                .padding([.top, .trailing], 15)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        VStack (alignment: .leading) {
                            Text(self.name)
                                .padding(EdgeInsets(top: 120, leading: 15, bottom: 0, trailing: 0))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
            
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
    }
}

struct RecipeRowView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRowView(name: "Recipe Name", category: "Category", image: .init(count: 0), favourited: false, itemID: UUID(), navDesc: .constant(false), selectID: .constant(UUID()))
    }
}
