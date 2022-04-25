//
//  RecipeListView.swift
//  CookScreen
//
//  Created by Blue Snow on 25/4/2565 BE.
//

import SwiftUI

struct RecipeListView: View {
    var body: some View {
        NavigationView {
            Color(.systemGray6)
                .ignoresSafeArea()
                .navigationTitle("List")
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
