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
            ZStack {
                Color.ui.cream3
                    .ignoresSafeArea()
                VStack {
                    NavigationLink(destination: AboutMeView(), tag: "aboutme", selection: $navSettingSelection) { EmptyView() }
                    Text("CookScreen 0.0.1")
                        .font(.system(size: 20, design: .default))
                        .foregroundColor(Color.ui.white)
                    List {
                        VStack(alignment: .leading){
                            Button {
                                self.navSettingSelection = "aboutme"
                            } label: {
                                Text("About Me")
                                    .font(.headline)
                            }
                        }
                    }
                    .background(Color.ui.cream1)
                    .onAppear { // Allows to change background color of the list
                      UITableView.appearance().backgroundColor = .clear
                    }
//                    .onDisappear {
//                      UITableView.appearance().backgroundColor = .systemGroupedBackground
//                    }
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
            }
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
