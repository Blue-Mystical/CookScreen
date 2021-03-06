//
//  CategoryItem.swift
//  CookScreen
//
//  Created by Blue Snow on 28/4/2565 BE.
//

import Foundation
import CoreData

// Core Data functions for Category Entity
public class Category:NSManagedObject, Identifiable {
    @NSManaged public var dateAdded: Date?
    @NSManaged public var name: String?
}

extension Category {
    
    // Get all categories
    static func getAllCategories() -> NSFetchRequest<Category> {
        let request:NSFetchRequest<Category> = Category.fetchRequest() as! NSFetchRequest<Category>
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
    
}
