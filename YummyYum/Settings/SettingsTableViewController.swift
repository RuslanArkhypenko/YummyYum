//
//  SettingsTableViewController.swift
//  YummyYum
//
//  Created by Ruslan Arhypenko on 2/18/19.
//  Copyright © 2019 Ruslan Arhypenko. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    var settingsParameters:Settings?

    override func viewDidLoad() {
        super.viewDidLoad()
        createSettingsParameters()
        self.clearsSelectionOnViewWillAppear = true
        self.tableView.tableFooterView = UIView()
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.settingsParameters!.settingsHeaderNames.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingsParameters!.settingsNames[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.settingsParameters!.settingsHeaderNames[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        cell.textLabel?.text = self.settingsParameters!.settingsNames[indexPath.section][indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow!
        let detailSettingsTableViewController = segue.destination as! DetailSettingsTableViewController
        detailSettingsTableViewController.settingsParameters = self.settingsParameters!.settingParameterNames[indexPath.section]
        detailSettingsTableViewController.settingsName = self.settingsParameters!.settingsNames[indexPath.section][indexPath.row]
    }
    
    func createSettingsParameters() {
        self.settingsParameters = Settings.init(settingsHeaderNames: Constants.settingsHeaderNames, settingsNames: Constants.settingsNames, settingParameterNames: Constants.settingParameterNames)
    }
}
