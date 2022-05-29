//
//  CategoryPickerView.swift
//  CookScreen
//
//  Created by Blue Snow on 2/5/2565 BE.
//

import SwiftUI

// This component is unused as I couldn't implement the multiple picker
struct CategoryPickerView: View {
    @State var categoryList: [String]
    @Binding var selectedCategories: [String]
    
    var body: some View {
        Form {
            List {
                ForEach(self.categoryList, id: \.self) { item in
                    Button(action: {
                        withAnimation {
                            if self.selectedCategories.contains(item) {
                                self.selectedCategories.removeAll(where: {$0 == item})
                            } else {
                                self.selectedCategories.append(item)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "checkmark")
                                .opacity(self.selectedCategories.contains(item) ? 1.0 : 0.0)
                            Text(item)
                        }
                    }
                }
            }
        }
    }
}

struct CategoryPickerView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoryPickerView(categoryList: [], selectedCategories: .constant([]))
    }
}
