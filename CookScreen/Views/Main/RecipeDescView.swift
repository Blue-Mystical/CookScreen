//
//  RecipeDescView.swift
//  CookScreen
//
//  Created by Blue Snow on 27/4/2565 BE.
//

import SwiftUI

struct RecipeDescView: View {
    @State var selectedRecipe: UUID
    
    var body: some View {
        Button {
            print(selectedRecipe)
        } label: {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct RecipeDescView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDescView(selectedRecipe: UUID())
    }
}
