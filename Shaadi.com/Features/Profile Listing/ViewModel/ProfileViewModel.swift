//
//  CardLitsViewModel.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/07/24.
//

import Foundation
import CoreData

protocol ProfileViewModelProtocol: ObservableObject {
    var profiles: [Profile] { get set }
    
    func fetchProfilesFromDB()
    func fetchProfilesFromAPI() async
    func addProfile(id: String, name: String, age: Int16, imageUrl: String, isLiked: Bool, isSelected: Bool, address: String)
    func updateProfile(_ profile: Profile, isLiked: Bool, isSelected: Bool)
    func deleteProfile(_ profile: Profile)
    func deleteAllProfiles()
}
class ProfileViewModel: ProfileViewModelProtocol {
    private let repository = ProfileRepository()
    private let webService = ProfileWebService(url: kWEB_URL)
    @Published var profiles: [Profile] = []

    init() {
        fetchProfilesFromDB()
    }

    // ✅ Fetch Profiles
    func fetchProfilesFromDB() {
        DispatchQueue.main.async {
            self.profiles = self.repository.fetchProfiles()
        }
    }
    func fetchProfilesFromAPI() async {
        let result = await webService.fetchProfiles()
        switch result {
        case .success(let userInfo):
            if let userInfo = userInfo {
                repository.insertProfiles(from: userInfo) {
                    self.fetchProfilesFromDB() // Refresh UI
                } // Save data to Core Data
            }
        case .failure(let error):
            print("Failed to fetch profiles: \(error)")
        }
    }
    // ✅ Add New Profile
    func addProfile(id: String, name: String, age: Int16, imageUrl: String, isLiked: Bool, isSelected: Bool, address: String) {
        repository.createProfile(id: id, name: name, age: age, imageUrl: imageUrl, isLiked: isLiked, isSelected: isSelected, address: address)
        fetchProfilesFromDB() // Refresh UI
    }

    // ✅ Update Profile
    func updateProfile(_ profile: Profile, isLiked: Bool, isSelected: Bool) {
        repository.updateProfile(profile: profile, isLiked: isLiked, isSelected: isSelected)
        fetchProfilesFromDB()
    }

    // ✅ Delete Profile
    func deleteProfile(_ profile: Profile) {
        repository.deleteProfile(profile: profile)
        fetchProfilesFromDB()
    }

    // ✅ Delete All Profiles
    func deleteAllProfiles() {
        repository.deleteAllProfiles()
        fetchProfilesFromDB()
    }
}
