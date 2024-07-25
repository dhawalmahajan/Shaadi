//
//  CardLitsViewModel.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/07/24.
//

import Foundation

@MainActor
class CardLitsViewModel: ObservableObject {
    private let webService: ProfileWebService
    private let coreDataManager: CoreDataManager
    @Published var user: [Profile]? = []
    
    init(webService: ProfileWebService, coreDataManager: CoreDataManager) {
        self.webService = webService
        self.coreDataManager = coreDataManager
    }
    
    func fetchWebService() async  {
        switch  await webService.fetchProfiles() {
        case .success(let info):
            let profile = info?.results.compactMap {
                coreDataManager.insertProfile(id: $0.login.uuid, name: $0.name.first, imageUrl: $0.picture.medium, age: Int16($0.dob.age), isLiked: false)
            }
            user = profile
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func updateProfile(id: String, isLiked: Bool) -> Profile? {
        return coreDataManager.updateProfile(id: id, isLiked: isLiked)
        }
}
