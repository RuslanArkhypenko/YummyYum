//
//  DetailFavouriteViewController.swift
//  YummyYum
//
//  Created by Ruslan Arhypenko on 3/6/19.
//  Copyright © 2019 Ruslan Arhypenko. All rights reserved.
//

import UIKit
import CoreData

class DetailFavouriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var recipe: RecipeCoreData!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recipe"
        navigationItem.largeTitleDisplayMode = .never
        fetchRecipeFromCoreData()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailFavouriteCell", for: indexPath)
        return cell
    }
    
    func fetchRecipeFromCoreData() {
        self.recipeNameLabel.text = self.recipe.name
        self.recipeImageView.image = UIImage(data: self.recipe.image! as Data)
        self.ratingLabel.text = self.recipe.rating
        self.cookingTimeLabel.text = self.recipe.cookingTime
    }
}
