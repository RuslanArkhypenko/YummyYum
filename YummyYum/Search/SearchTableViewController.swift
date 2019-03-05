//
//  SearchTableViewController.swift
//  YummyYum
//
//  Created by Ruslan Arhypenko on 2/19/19.
//  Copyright © 2019 Ruslan Arhypenko. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    let defaults = UserDefaults.standard
    let searchController = UISearchController(searchResultsController: nil)

    var noRecipesView = NoRecipesView()
    
    var recipes = [SearchRecipe]()
    var searchParameters: String!
    var page: Int!
    var totalMatchCount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true

        setupSearchController()
        setupTitleViewGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupSearchController() {
        self.searchController.searchBar.delegate = self
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
        let color = UIColor.init(red: 246.0/255.0, green: 160.0/255.0, blue: 13.0/255.0, alpha: 1.0)
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: color]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
    }
    
    func setupTitleViewGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(navigationBarTapped(_:)))
        self.navigationController?.navigationBar.addGestureRecognizer(tapGestureRecognizer)
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.recipes.count > 0 {
            self.tableView.backgroundView = nil
        } else {
            self.noRecipesView.title.text = "Start search recipes!"
            self.tableView.backgroundView = self.noRecipesView
        }
        return self.recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchRecipeTableViewCell
        let recipe = self.recipes[indexPath.row]
        cell.recipeName.text = recipe.name
        cell.rating.text = "\(recipe.rating!)"
        
        if (recipe.image != nil) {
            cell.recipeImage.image = recipe.image
        } else {
            Alamofire.request(recipe.imageUrlString!).responseImage { response in
                if let image = response.result.value {
                    cell.recipeImage?.image = image
                    recipe.image = image
                }
            }
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row  == self.recipes.count - 2 && self.page <= self.totalMatchCount {
            getRecipesFromAPI(withSearchParameters: self.searchParameters, andPage: self.page)
        }
    }
    
    // MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.page = 0
        self.searchParameters = searchText.replacingOccurrences(of: " ", with: "+")
        self.recipes.removeAll()
        self.tableView.reloadData()
        getRecipesFromAPI(withSearchParameters: self.searchParameters, andPage: self.page)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.searchController.dismiss(animated: true, completion: nil)
    }
 
     // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow!
        let detailSearchViewController = segue.destination as! DetailSearchViewController
        detailSearchViewController.recipeID = self.recipes[indexPath.row].id
    }
    
    // MARK: - Actions
    
    @objc func navigationBarTapped(_ sender: UITapGestureRecognizer) {
        let indexPath = IndexPath(item: 0, section: 0)
        if self.recipes.count > 0 {
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    // MARK: - API

    func getRecipesFromAPI(withSearchParameters searchParameters: String, andPage page: Int) {
    
        ServerManager.sharedManager.getRecipesFromAPIBySearch(page: page, searchParameters: searchParameters, onSucces: { (recipe: [SearchRecipe], totalMatchCount: Int) in
            self.recipes.append(contentsOf: recipe)
            self.page += Constants.numberOfRecipesPerRequest
            self.totalMatchCount = totalMatchCount
            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
