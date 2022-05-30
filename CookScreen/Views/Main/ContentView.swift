//
//  ContentView.swift
//  CookScreen
//
//  Created by Blue Snow on 19/4/2565 BE.
//

import SwiftUI

public enum Tab {
    case recipetab
    case shoppingtab
    case categorytab
    case settingstab
}

struct TabButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.9 : 1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}

// Main screen view and navigation
struct ContentView: View {
    @State public var selectedTab: Tab = .recipetab
    @State public var navSelection: String? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: RecipeAddEditView(editingMode: false), tag: "add", selection: $navSelection) { EmptyView() }
                switch selectedTab {
                case .recipetab:
                    RecipeListView()
                case .shoppingtab:
                    ShoppingListView()
        //      case .addrecipetab:
        //          RecipeAddEditView(editingMode: false, recipeID: UUID())
                case .categorytab:
                        CategoryListView()
                case .settingstab:
                    SettingsView()
                }
                NavBar(selectedTab: $selectedTab, navSelection: $navSelection)
                    .frame(height: 50)
            }
        }
    }
}

// Navigation Tab with a big 'add' button in the middle
struct NavBar: View {
    @Binding var selectedTab: Tab
    @Binding var navSelection: String?
    var body: some View {
        HStack {
            Spacer()
            Group {
                // Home or recipe tab
                Button {
                    selectedTab = .recipetab
                } label: {
                    VStack {
                        Image(systemName: "house")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text("Recipes")
                            .font(.caption2)
                    }
                    .foregroundColor(selectedTab == .recipetab ? .blue : .primary)
                }
                Spacer()
                // favourite recipe tab
                Button {
                    selectedTab = .shoppingtab
                } label: {
                    VStack {
                        Image(systemName: "list.bullet.rectangle.portrait")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text("Buy List")
                            .font(.caption2)
                    }
                    .foregroundColor(selectedTab == .shoppingtab ? .blue : .primary)
                }
            }
            // Add recipe button
            Spacer()
            Button {
                navSelection = "add"
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80)
                        .shadow(radius: 2)
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(.primary)
                        .frame(width: 72, height: 72)
                }
                .offset(y: -32)
            }
            .buttonStyle(TabButtonStyle())
            Group {
                // category recipe tab
                Button {
                    selectedTab = .categorytab
                } label: {
                    VStack {
                        Image(systemName: "tag")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text("Categories")
                            .font(.caption2)
                    }
                    .foregroundColor(selectedTab == .categorytab ? .blue : .primary)
                }
                Spacer()
                // settings tab
                Button {
                    selectedTab = .settingstab
                } label: {
                    VStack {
                        Image(systemName: "gearshape")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text("Settings")
                            .font(.caption2)
                    }
                    .foregroundColor(selectedTab == .settingstab ? .blue : .primary)
                }
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
