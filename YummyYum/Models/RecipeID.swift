//
//  RecipeID.swift
//  YummyYum
//
//  Created by Ruslan Arhypenko on 3/1/19.
//  Copyright © 2019 Ruslan Arhypenko. All rights reserved.
//

import UIKit

class RecipeID: NSObject {
    
    var course: [String]!
    var cuisine: [String]!
    var sourceRecipeUrl: URL!
    var hostedLargeUrl: URL!
    var ingredientLines: [String]!
    var name: String!
    var totalTime: String!
    var rating: Int!
    
    init(serverResponse: NSDictionary) {
        print(serverResponse)
        
        if let attributes = serverResponse["attributes"] as? [String:Any] {
            if let course = attributes["course"] as? [String] {
                self.course = course
            }
            
            if let cuisine = attributes["cuisine"] as? [String] {
                self.cuisine = cuisine
            }
        }
        
        if let source = serverResponse["source"] as? [String:Any] {
            if let sourceRecipeUrl = source["sourceRecipeUrl"] as? String {
                self.sourceRecipeUrl = URL(string: sourceRecipeUrl)
            }
        }
        
        if let images = serverResponse["images"] as? [Any] {
            if let imagesDict = images[0] as? [String:Any] {
                if let hostedLargeUrl = imagesDict["hostedLargeUrl"] as? String {
                    self.hostedLargeUrl = URL(string: hostedLargeUrl)
                }
            }
        }
        
        if let ingredientLines = serverResponse["ingredientLines"] as? [String] {
            self.ingredientLines = ingredientLines
        }
        
        if let name = serverResponse["name"] as? String {
            self.name = name
        }
        
        if let totalTime = serverResponse["totalTime"] as? String {
            self.totalTime = totalTime
        }
        
        if let rating = serverResponse["rating"] as? Int {
            self.rating = rating
        }
    }
}
