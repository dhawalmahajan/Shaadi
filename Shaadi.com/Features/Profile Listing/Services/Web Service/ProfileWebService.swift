//
//  ProfileWebService.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/07/24.
//

import Foundation
import CoreData
protocol ProfileServiceProtocol {
    func fetchProfiles(results: Int, page: Int) async -> Result<UserInfo?, Error>
}
class ProfileWebService:ProfileServiceProtocol {
    private let urlBuilder: APIURLBuilder
    init(url: String) {
        self.urlBuilder = APIURLBuilder(baseURL: url)
    }
    func fetchProfiles (results: Int, page: Int) async -> Result<UserInfo?,Error>{
        let urlResult = urlBuilder.buildURL(results: results, page: page)
        switch urlResult {
        case .success(let url):
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let userInfo = try JSONDecoder().decode(UserInfo.self, from: data)
                return .success(userInfo)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
        
    }
}
