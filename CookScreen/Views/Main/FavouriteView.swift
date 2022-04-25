//
//  FavouriteView.swift
//  CookScreen
//
//  Created by Blue Snow on 25/4/2565 BE.
//

import SwiftUI

struct FavouriteView: View {
    var body: some View {
        NavigationView {
            Color(.systemGray6)
                .ignoresSafeArea()
                .navigationTitle("Fav")
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
