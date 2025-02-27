//
//  CoreDataManager.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 25/07/24.
//

import Foundation
import CoreData
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    private init() {
        container = NSPersistentContainer(name: kCONTAINER_NAME) // Replace with your actual model name
        container.loadPersistentStores { storeDescription , error in
            if let error = error {
                debugPrint("Failed to load Core Data stack: \(error)")
            } else  if let pathUrl = storeDescription.url {
                debugPrint("Core Data DB Path: \(pathUrl.path)")
            } else {
                debugPrint("Could not find Core Data database path")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func saveContext() {
        let context = viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                debugPrint("Failed to save Core Data: \(error)")
            }
        }
    }
}
