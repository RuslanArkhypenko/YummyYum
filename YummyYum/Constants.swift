//
//  Constants.swift
//  YummyYum
//
//  Created by Ruslan Arhypenko on 2/19/19.
//  Copyright © 2019 Ruslan Arhypenko. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    static let numberOfRecipesPerRequest = 20
    
    static let NSUserDefaultsSettingsKeyValues = ["Allowed allergy",
                                                  "Allowed diet",
                                                  "Allowed cousine", "Exclude cuisine",
                                                  "Allowed course", "Exclude course",
                                                  "Allowed holiday", "Exclude holiday"]
    
    static let settingsHeaderNames = ["Allergy", "Diet", "Cuisine", "Course", "Holiday"]
        
    static let settingsNames = [["Allowed allergy"],
                                ["Allowed diet"],
                                ["Allowed cousine", "Exclude cuisine"],
                                ["Allowed course", "Exclude course"],
                                ["Allowed holiday", "Exclude holiday"]]
    
    static let settingParameterNames = [["Dairy", "Egg", "Gluten, Peanut", "Seafood, Sesame", "Soy, Sulfite", "Tree Nut", "Wheat"],
                             ["Lacto vegetarian", "Ovo vegetarian", "Pescetarian", "Vegan", "Vegetarian"],
                             ["American", "Italian", "Asian", "Mexican", "Southern & Soul Food", "French", "Southwestern", "Barbecue", "Indian", "Chinese", "Cajun & Creole", "English", "Mediterranean", "Greek", "Spanish", "German", "Thai", "Moroccan", "Irish", "Japanese", "Cuban", "Hawaiin", "Swedish", "Hungarian", "Portugese"],
                             ["Main Dishes", "Desserts", "Side Dishes", "Lunch and Snacks", "Appetizers", "Salads", "Breads", "Breakfast and Brunch", "Soups", "Beverages", "Condiments and Sauces", "Cocktails"],
                             ["Christmas", "Summer", "Thanksgiving", "New Year", "Super Bowl / Game Day", "Halloween", "Hanukkah", "4th of July"]]
}
