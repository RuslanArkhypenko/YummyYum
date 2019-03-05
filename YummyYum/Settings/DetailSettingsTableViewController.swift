//
//  DetailSettingsTableViewController.swift
//  YummyYum
//
//  Created by Ruslan Arhypenko on 2/18/19.
//  Copyright © 2019 Ruslan Arhypenko. All rights reserved.
//

import UIKit

class DetailSettingsTableViewController: UITableViewController {

    let defaults = UserDefaults.standard
    
    var settingsParameters: [String]?
    var settingsName = String()
    var selectedParameters = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.settingsName
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingsParameters!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storedParameters = getMarkedParameters()
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailSettingsCell", for: indexPath)
        cell.textLabel?.text = self.settingsParameters![indexPath.row]
        cell.accessoryType = self.settingsParameters![indexPath.row] == storedParameters[String(indexPath.row)] ? .checkmark : .none
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            self.selectedParameters.removeValue(forKey: String(indexPath.row))
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            self.selectedParameters[String(indexPath.row)] = self.settingsParameters![indexPath.row]
        }
        saveMarkedParameters()
    }
    
    func saveMarkedParameters() {
        self.defaults.set(self.selectedParameters, forKey: self.settingsName)
    }
    
    func getMarkedParameters() -> [String:String] {
        let markedParameters = defaults.dictionary(forKey: self.settingsName)
        return (markedParameters as? [String : String] ?? ["":""])
    }
}
