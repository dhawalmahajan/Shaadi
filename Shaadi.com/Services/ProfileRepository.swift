//
//  ProfileRepository.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/02/25.
//

import CoreData

class ProfileRepository {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataManager.shared.viewContext) {
        self.context = context
    }

    // ✅ Create Profile
    func createProfile(id: String, name: String, age: Int16, imageUrl: String, isLiked: Bool, isSelected: Bool, address: String) {
        let profile = Profile(context: context)
        profile.id = id
        profile.name = name
        profile.age = age
        profile.imageUrl = imageUrl
        profile.isLiked = isLiked
        profile.isSelected = isSelected
        profile.address = address

        save()
    }
    func insertProfiles(from userInfo: UserInfo, completion: (() -> Void)? = nil) {
           let backgroundContext = CoreDataManager.shared.container.newBackgroundContext()
        backgroundContext.perform {
            for user in userInfo.results {
                let profile = Profile(context: backgroundContext)
                profile.id = user.login.uuid
                profile.name = user.name.first
                profile.age = Int16(user.dob.age)
                profile.imageUrl = user.picture.medium
                profile.isLiked = false
                profile.isSelected = false
                profile.address = user.location.city
            }
            
            do {
                try backgroundContext.save() // 🔥 Ensure explicit saving
                print("✅ Successfully saved profiles to Core Data.")
                DispatchQueue.main.async {
                    completion?()
                }
            } catch {
                print("❌ Failed to save profiles: \(error)")
            }
        }
       }

    // ✅ Fetch All Profiles
    func fetchProfiles() -> [Profile] {
        let request: NSFetchRequest<Profile> = Profile.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch profiles: \(error)")
            return []
        }
    }

    // ✅ Update Profile
    func updateProfile(profile: Profile, isLiked: Bool, isSelected: Bool) {
        profile.isLiked = isLiked
        profile.isSelected = isSelected
        save()
    }

    // ✅ Delete Profile
    func deleteProfile(profile: Profile) {
        context.delete(profile)
        save()
    }

    // ✅ Delete All Profiles
    func deleteAllProfiles() {
        let request: NSFetchRequest<NSFetchRequestResult> = Profile.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)

        do {
            try context.execute(deleteRequest)
            save()
        } catch {
            print("Failed to delete all profiles: \(error)")
        }
    }

    // ✅ Save Context
    private func save() {
        do {
            try context.save()
        } catch {
            print("Failed to save Core Data: \(error)")
        }
    }
}
