//
//  DataController.swift
//  CookScreen
//
//  Created by Blue Snow on 25/4/2565 BE.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let persistentContainer: NSPersistentContainer
    static let shared: DataController = DataController()
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "CookScreenModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Cannot initialize core data \(error)")
            }
        }
    }
}
