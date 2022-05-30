//
//  ShoppingRowView.swift
//  CookScreen
//
//  Created by Blue Snow on 30/5/2565 BE.
//

import SwiftUI

struct ShoppingRowView: View {
    var name: String = ""
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(name)
                    .font(.headline)
            }
            
        }
    }
}

struct ShoppingRowView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingRowView(name: "Undefined")
    }
}
