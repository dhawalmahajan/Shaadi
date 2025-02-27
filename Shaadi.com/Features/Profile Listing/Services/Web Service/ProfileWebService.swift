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
    /// Fetches a list of user profiles from the API with pagination support.
    ///
    /// This function asynchronously requests user profile data from the server,
    /// based on the specified number of results per page and the page number.
    /// It returns either a `UserInfo` object containing profile details or an `Error`
    /// if the request fails.
    ///
    /// - Parameters:
    ///   - results: The number of profiles to fetch per page.
    ///   - page: The page number to retrieve.
    ///
    /// - Returns: A `Result<UserInfo?, Error>` containing either:
    ///   - `.success(UserInfo?)`: The fetched profile data (or `nil` if empty).
    ///   - `.failure(Error)`: An error if the request fails.
    ///
    /// - Example:
    /// ```swift
    /// let result = await profileWebService.fetchProfiles(results: 10, page: 1)
    /// switch result {
    /// case .success(let userInfo):
    ///     print("Fetched profiles: \(userInfo?.results.count ?? 0)")
    /// case .failure(let error):
    ///     print("Error fetching profiles: \(error.localizedDescription)")
    /// }
    /// ```
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
