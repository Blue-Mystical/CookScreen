//
//  ShoppingItem.swift
//  CookScreen
//
//  Created by Blue Snow on 30/5/2565 BE.
//

import Foundation
import CoreData

public class ShoppingItem:NSManagedObject, Identifiable {
    @NSManaged public var dateAdded: Date?
    @NSManaged public var name: String?
}

extension ShoppingItem {
    
    static func getAllShopItems() -> NSFetchRequest<ShoppingItem> {
        let request:NSFetchRequest<ShoppingItem> = ShoppingItem.fetchRequest() as! NSFetchRequest<ShoppingItem>
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
    
}
