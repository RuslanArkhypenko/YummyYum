//
//  Settings.swift
//  YummyYum
//
//  Created by Ruslan Arhypenko on 2/20/19.
//  Copyright © 2019 Ruslan Arhypenko. All rights reserved.
//

import UIKit

class Settings: NSObject {
    
    let settingsHeaderNames: [String]
    let settingsNames: [[String]]
    var settingParameterNames: [[String]]
    
    init(settingsHeaderNames: [String], settingsNames: [[String]], settingParameterNames: [[String]]) {
        self.settingsHeaderNames = settingsHeaderNames
        self.settingsNames = settingsNames
        self.settingParameterNames = settingParameterNames
    }
}

