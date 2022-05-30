//
//  RecipeItem.swift
//  CookScreen
//
//  Created by Blue Snow on 3/5/2565 BE.
//

import Foundation
import CoreData

public class Recipe:NSManagedObject, Identifiable {
    @NSManaged public var category: String?
    @NSManaged public var cookingtime: Int32
    @NSManaged public var dateadded: Date?
    @NSManaged public var desc: String?
    @NSManaged public var directions: String?
    @NSManaged public var favourited: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var ingredients: String?
    @NSManaged public var name: String?
    @NSManaged public var nutrition: Int32
    @NSManaged public var yield: Int32
}

extension Recipe {
    
    static func getAllRecipes() -> NSFetchRequest<Recipe> {
        let request:NSFetchRequest<Recipe> = Recipe.fetchRequest() as! NSFetchRequest<Recipe>
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }

}
