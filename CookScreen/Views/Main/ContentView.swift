//
//  ContentView.swift
//  CookScreen
//
//  Created by Blue Snow on 19/4/2565 BE.
//

import SwiftUI

enum Tab {
    case recipetab
    case favtab
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
                RecipeListView()
            case .favtab:
                FavouriteView()
            }
            CustomTabView(selectedTab: $selectedTab)
                .frame(height: 50)
        }
    }
}

// Navigation Tab with a big 'add' button in the middle
struct CustomTabView: View {
    @Binding var selectedTab: Tab
    var body: some View {
        HStack {
            Spacer()
            Button {
                selectedTab = .recipetab
            } label: {
                VStack {
                    Image(systemName: "house")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    Text("Home")
                        .font(.caption2)
                }
                .foregroundColor(selectedTab == .recipetab ? .blue : .primary)
            }
            Spacer()
            // Add recipe button
            Button {
                
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
            Spacer()
            Button {
                selectedTab = .favtab
            } label: {
                VStack {
                    Image(systemName: "chart.bar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    Text("Favourite")
                        .font(.caption2)
                }
                .foregroundColor(selectedTab == .favtab ? .blue : .primary)
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
