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
    func fetchProfilesFromAPI(reset: Bool) async
    func addProfile(id: String, name: String, age: Int16, imageUrl: String, isLiked: Bool, isSelected: Bool, address: String)
    func updateProfile(_ profile: Profile, isLiked: Bool, isSelected: Bool)
    func deleteProfile(_ profile: Profile)
    func deleteAllProfiles()
}
class ProfileViewModel: ProfileViewModelProtocol {
    
    private let repository = ProfileRepository()
    private let webService: ProfileWebService
    private var currentPage = 1
    private let resultsPerPage = 10
    private var isFetching = false
    @Published var profiles: [Profile] = []

    init(profileService: ProfileWebService = ProfileWebService(url: kWEB_URL)) {
        self.webService = profileService
        fetchProfilesFromDB()
    }

    // ✅ Fetch Profiles
    func fetchProfilesFromDB() {
        DispatchQueue.main.async {
            self.profiles = self.repository.fetchProfiles()
        }
    }
    @MainActor
    func fetchProfilesFromAPI(reset: Bool = false) async {
        guard !isFetching else { return }
        isFetching = true
        if reset {
            currentPage = 1
            repository.deleteAllProfiles()
            profiles.removeAll()
        }
        let result = await webService.fetchProfiles(results: resultsPerPage, page: currentPage)
        switch result {
        case .success(let userInfo):
            if let userInfo = userInfo {
                repository.insertProfiles(from: userInfo) {
                    self.fetchProfilesFromDB()
                    self.currentPage += 1
                }
            }
        case .failure(let error):
            print("Failed to fetch profiles: \(error)")
        }
        self.isFetching = false
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
