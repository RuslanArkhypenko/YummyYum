//
//  RecipeCoreData+CoreDataProperties.swift
//  
//
//  Created by Ruslan Arhypenko on 3/2/19.
//
//

import Foundation
import CoreData


extension RecipeCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeCoreData> {
        return NSFetchRequest<RecipeCoreData>(entityName: "RecipeCoreData")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: NSData?
    @NSManaged public var rating: String?
    @NSManaged public var cookingTime: String?

}
