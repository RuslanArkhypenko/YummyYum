//
//  CoreDataManager.swift
//  YummyYum
//
//  Created by Ruslan Arhypenko on 3/2/19.
//  Copyright © 2019 Ruslan Arhypenko. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

    static let sharedManager = CoreDataManager()

    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "YummyYum")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
