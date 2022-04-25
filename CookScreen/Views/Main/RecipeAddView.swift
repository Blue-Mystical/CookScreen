//
//  RecipeAddView.swift
//  CookScreen
//
//  Created by Blue Snow on 25/4/2565 BE.
//

import SwiftUI

struct RecipeAddView: View {
    var body: some View {
        NavigationView {
            Color(.systemGray6)
                .ignoresSafeArea()
                .navigationTitle("Add")
        }
    }
}

struct RecipeAddView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeAddView()
    }
}
