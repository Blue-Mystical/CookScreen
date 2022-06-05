//
//  CookScreenApp.swift
//  CookScreen
//
//  Created by Blue Snow on 19/4/2565 BE.
//

import SwiftUI

@main
struct CookScreenApp: App {
    // setup core data function controller
    let dataContainer = DataController.shared.persistentContainer

    var body: some Scene {
        WindowGroup {
            ContentView()
            // load data controller for ContentView
                .environment(\.managedObjectContext, dataContainer.viewContext)
        }
    }
}
