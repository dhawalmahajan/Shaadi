//
//  UserInfo.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/07/24.
//

import Foundation
// MARK: - Welcome
struct UserInfo: Codable {
    let results: [UserResult]
    let info: Info
}

// MARK: - Info
struct Info: Codable {
    let seed: String
    let results, page: Int
    let version: String
}

// MARK: - Result
struct UserResult: Codable,Identifiable {
    
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob, registered: Dob
    let phone, cell: String
    let id: ID
    let picture: Picture
    let nat: String
//    var isLiked: Bool = false
}

// MARK: - Dob
struct Dob: Codable {
    let date: String
    let age: Int
}

// MARK: - ID
struct ID: Codable,Hashable {
    let name: String
    let value: String?
}

// MARK: - Location
struct Location: Codable {
 
    let city, state, country: String
//    let postcode: String
    
    
}


// MARK: - Street



// MARK: - Login
struct Login: Codable {
    let uuid, username, password, salt: String
    let md5, sha1, sha256: String
}

// MARK: - Name
struct Name: Codable {
    let title, first, last: String
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String
}

extension UserResult {


    
    static let placeholderProfile = UserResult(gender: "Male", name: .init(title: "Mr.", first: "Felix", last: "Sørensen"), location: .init(city: "Saltum",state: "Sjælland", country: "Denmark"), email: "abc@def.com", login: .init(uuid: "1", username: "abc", password: "abc", salt: "3", md5: "123", sha1: "1234", sha256: "12345"), dob: .init(date: "1947-07-01T09:38:31.640Z", age: 21), registered: .init(date: "2003-01-18T04:23:00.013Z", age: 21), phone:  "01-6005-0671", cell: "0468-466-258", id: .init(name: "TFN", value: "503921876"), picture: .init(large: "https://randomuser.me/api/portraits/men/9.jpg", medium: "https://randomuser.me/api/portraits/med/men/9.jpg", thumbnail: "https://randomuser.me/api/portraits/thumb/men/9.jpg"), nat: "AU")
}


