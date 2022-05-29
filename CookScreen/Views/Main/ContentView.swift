//
//  ContentView.swift
//  CookScreen
//
//  Created by Blue Snow on 19/4/2565 BE.
//

import SwiftUI

public enum Tab {
    case recipetab
    case favtab
    case addrecipetab
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
    @State private var selectedTab: Tab = .recipetab
    
    var body: some View {
        VStack {
            switch selectedTab {
            case .recipetab:
                RecipeListView(favouriteMode: false)
            case .favtab:
                RecipeListView(favouriteMode: true)
            case .addrecipetab:
                RecipeAddView(editingMode: false, recipeID: UUID())
            case .categorytab:
                CategoryListView()
            case .settingstab:
                SettingsView()
            }
            NavBar(selectedTab: $selectedTab)
                .frame(height: 50)
        }
    }
}

// Navigation Tab with a big 'add' button in the middle
struct NavBar: View {
    @Binding var selectedTab: Tab
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
                    selectedTab = .favtab
                } label: {
                    VStack {
                        Image(systemName: "suit.heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text("Favourite")
                            .font(.caption2)
                    }
                    .foregroundColor(selectedTab == .favtab ? .blue : .primary)
                }
            }
            // Add recipe button
            Button {
                selectedTab = .addrecipetab
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
