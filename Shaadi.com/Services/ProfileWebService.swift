//
//  ProfileWebService.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/07/24.
//

import Foundation
import CoreData
class ProfileWebService {
    private let url: String?
    init(url: String?) {
        self.url = url
    }
    func fetchProfiles () async -> Result<UserInfo?,Error>{
        guard let url = URL(string: url ?? "") else {return .failure(URLError(.badURL)) }
        do {
           let (data,_) = try  await URLSession.shared.data(from: url)
            let info = try JSONDecoder().decode(UserInfo.self, from: data)
            
            return .success(info)
        } catch let error  {
            debugPrint(error)
            return .failure(error)
        }
       
    }
}
