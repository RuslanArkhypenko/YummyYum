//
//  Recipe.swift
//  YummyYum
//
//  Created by Ruslan Arhypenko on 2/20/19.
//  Copyright © 2019 Ruslan Arhypenko. All rights reserved.
//

import UIKit

class SearchRecipe: NSObject {
    
    var flavors: [String:Double]!
    var id: String!
    var ingredients: [String]!
    var rating: Int!
    var name: String!
    var image: UIImage!
    var imageUrlString: String!
    var sourceName: String!
    var totalTimeInSeconds: Int!
    
    init(serverResponse: NSDictionary) {

        if let flavors = serverResponse["flavors"] as? [String:Double] {
            self.flavors = flavors
        }
        
        if let id = serverResponse["id"] as? String {
            self.id = id
        }
        if let ingredients = serverResponse["ingredients"] as? [String] {
            self.ingredients = ingredients
        }
    
        if let rating = serverResponse["rating"] as? Int {
            self.rating = rating
        }
        
        if let recipeName = serverResponse["recipeName"] as? String {
            self.name = recipeName
        }
        
        if let imageUrl = serverResponse["imageUrlsBySize"] as? [String:String] {
            self.imageUrlString = imageUrl["90"]
        }
        
        
        if let sourceDisplayName = serverResponse["sourceDisplayName"] as? String {
            self.sourceName = sourceDisplayName
        }
        
        if let totalTimeInSeconds = serverResponse["totalTimeInSeconds"] as? Int {
            self.totalTimeInSeconds = totalTimeInSeconds
        }
    }
}
