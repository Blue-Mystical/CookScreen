//
//  CategoryRowView.swift
//  CookScreen
//
//  Created by Blue Snow on 28/4/2565 BE.
//

import SwiftUI

struct CategoryRowView: View {
    var name: String = ""
    
    
    @Binding var navFilteredList: Bool
    @Binding var selectCategory: String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Button {
                    selectCategory = name
                    navFilteredList = true
                } label: {
                    Text(name)
                        .font(.headline)
                }
            }
            
        }
    }
}

struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRowView(name: "Undefined", navFilteredList: .constant(false), selectCategory: .constant(""))
    }
}
