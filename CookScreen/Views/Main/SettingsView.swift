//
//  SettingsView.swift
//  CookScreen
//
//  Created by Blue Snow on 25/4/2565 BE.
//

import SwiftUI

// All the settings, some of the functions are only mockups
struct SettingsView: View {
    
    @State private var navSettingSelection: String? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: AboutMeView(), tag: "aboutme", selection: $navSettingSelection) { EmptyView() }
                Text("CookScreen Version 0.0.1")
                List {
                    VStack(alignment: .leading){
                        Button {
                            self.navSettingSelection = "aboutme"
                        } label: {
                            Text("About us")
                                .font(.headline)
                        }
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
