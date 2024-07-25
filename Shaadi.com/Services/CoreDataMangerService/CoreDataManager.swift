//
//  CoreDataManager.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 25/07/24.
//

import Foundation
import CoreData
class CoreDataManager {
    func saveContext() {
        let context = PersistenceController.shared.viewContext
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
       }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
            let entityName = String(describing: objectType)
            let fetchRequest = NSFetchRequest<T>(entityName: entityName)
            
            do {
                let fetchedObjects = try PersistenceController.shared.viewContext.fetch(fetchRequest)
                return fetchedObjects
            } catch {
                print("Failed to fetch objects: \(error)")
                return []
            }
        }
    
    func updateProfile(id: String, isLiked: Bool) -> Profile? {
            let fetchRequest: NSFetchRequest<Profile> = Profile.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

            do {
                let profiles = try PersistenceController.shared.viewContext.fetch(fetchRequest)
                if let profile = profiles.first {
                    profile.isLiked = isLiked
                    saveContext()
                    return profile
                }
            } catch {
                print("Failed to fetch profile: \(error)")
            }
        return nil
        }
    
    func insertProfile(id: String, name: String, imageUrl:String, age: Int16, isLiked: Bool) -> Profile{
        let profile = Profile(context: PersistenceController.shared.viewContext)
           profile.id = id
           profile.name = name
           profile.age = age
        profile.imageUrl = imageUrl
           profile.isLiked = isLiked
           saveContext()
        return profile
       }
}
