//
//  RecipeIDViewController.swift
//  YummyYum
//
//  Created by Ruslan Arhypenko on 3/1/19.
//  Copyright © 2019 Ruslan Arhypenko. All rights reserved.
//

import UIKit
import SafariServices
import Alamofire
import AlamofireImage
import CoreData
import UserNotifications

class DetailSearchViewController: UIViewController, SFSafariViewControllerDelegate, UNUserNotificationCenterDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let viewContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    var recipeID: String!
    var recipe: RecipeID!
    var viewIsIn = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recipe"
        UNUserNotificationCenter.current().delegate = self
        addBarButtonItem()
        getRecipesFromAPI(with: self.recipeID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func addBarButtonItem() {
        let toWebsiteRightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "ToSite.png"), style: .done, target: self, action: #selector(moveToWebsiteTapped(_:)))
        let toFavouriteRightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "ToFavourite.png"), style: .done, target: self, action: #selector(moveToFavouriteTapped(_:)))
        self.navigationItem.rightBarButtonItems = [toWebsiteRightBarButtonItem, toFavouriteRightBarButtonItem]
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeInfoCell", for: indexPath)
        return cell
    }
    
    // MARK: - Actions

    @objc func moveToWebsiteTapped(_ sender: UIBarButtonItem) {
        
        if (self.recipe.sourceRecipeUrl != nil) {
            let safariViewController = SFSafariViewController(url: self.recipe.sourceRecipeUrl)
            self.present(safariViewController, animated: true, completion: nil)
            safariViewController.delegate = self
        } else {
            print("ERROR!")
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @objc func moveToFavouriteTapped(_ sender: UIBarButtonItem) {
        
        let recipe = NSEntityDescription.insertNewObject(forEntityName: "RecipeCoreData", into: self.viewContext) as! RecipeCoreData
        
        recipe.name = self.recipeNameLabel.text
        recipe.rating = self.ratingLabel.text
        recipe.cookingTime = self.cookingTimeLabel.text
        recipe.image = self.recipeImageView.image?.pngData() as NSData?
        
        do {
            try recipe.managedObjectContext?.save()
            callNotification(title: self.recipeNameLabel.text)
            sender.isEnabled = false
        } catch {
            print("Didn't save")
        }
    }
    
    func callNotification(title: String?) {
        
        let content = UNMutableNotificationContent()
        if let title = title {
            content.body = "\(title) added to Favourite!"
        }
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
        let request = UNNotificationRequest(identifier: "AddedToCoreData", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: UNUserNotificationCenterDelegate

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

    // MARK: API
    
    func getRecipeImageFromAPI(from url: URL) {
        
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                self.recipeImageView.image = image
            }
        }
    }
    
    func getRecipesFromAPI(with recipeID: String) {
        
        ServerManager.sharedManager.getRecipesFromAPIByID(recipeID: recipeID, onSucces: { (recipe: RecipeID) in
            self.recipe = recipe
            self.recipeNameLabel.text = recipe.name
            self.ratingLabel.text = "\(recipe.rating!)"
            self.cookingTimeLabel.text = recipe.totalTime
            self.getRecipeImageFromAPI(from: recipe.hostedLargeUrl)
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
}
