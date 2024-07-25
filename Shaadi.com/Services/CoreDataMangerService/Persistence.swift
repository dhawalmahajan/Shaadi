//
//  Persistence.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/07/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    var viewContext: NSManagedObjectContext {
           return container.viewContext
       }

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Shaadi_com")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                debugPrint(error)
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
