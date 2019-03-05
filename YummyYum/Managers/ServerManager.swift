//
//  ServerManager.swift
//  YummyYum
//
//  Created by Ruslan Arhypenko on 2/20/19.
//  Copyright © 2019 Ruslan Arhypenko. All rights reserved.
//

import UIKit
import Alamofire

class ServerManager: NSObject {
    
    static let sharedManager = ServerManager()
    
    func getRecipesFromAPIBySearch(page: Int, searchParameters: String, onSucces:@escaping (_ recipe:[SearchRecipe], _ totalMatchCount: Int) -> (), onFailure: @escaping (_ error: Error) -> ()) {
        
        let urlString = "https://api.yummly.com/v1/api/recipes?_app_id=e8072583&_app_key=25d5754cd21158048872a86b81404c4c&q=\(searchParameters)&maxResult=\(Constants.numberOfRecipesPerRequest)&start=\(page)&requirePictures=true"

        Alamofire.request(urlString).responseJSON { response in
            switch response.result {
            case .success(let value):
                let JSON = value as! [String:Any]
                let data = JSON["matches"] as! [Any]
                let totalMatchCount = JSON["totalMatchCount"] as! Int
                var recipesArray = [SearchRecipe]()

                for obj in data {
                    let recipe = SearchRecipe.init(serverResponse: obj as! NSDictionary)
                    recipesArray.append(recipe)
                }
                onSucces(recipesArray, totalMatchCount)
            case .failure(let error):
                onFailure(error)
            }
        }
    }
    
    func getRecipesFromAPIByID(recipeID: String, onSucces:@escaping (_ recipe:RecipeID) -> (), onFailure: @escaping (_ error: Error) -> ()) {

        let urlString = "https://api.yummly.com/v1/api/recipe/\(recipeID)?_app_id=e8072583&_app_key=25d5754cd21158048872a86b81404c4c"
        
        Alamofire.request(urlString).responseJSON { response in
            switch response.result {
            case .success(let value):
                let JSON = value as! [String:Any]
                let recipe = RecipeID.init(serverResponse: JSON as NSDictionary)
                onSucces(recipe)
            case .failure(let error):
                onFailure(error)
            }
        }
    }
}

