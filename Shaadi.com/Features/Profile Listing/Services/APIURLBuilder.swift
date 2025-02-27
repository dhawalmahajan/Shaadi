//
//  APIURLBuilder.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 27/02/25.
//

import Foundation
class APIURLBuilder {
    private var baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func buildURL(results: Int, page: Int) -> Result<URL, URLError> {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return .failure(URLError(.badURL))
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "results", value: "\(results)"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let url = urlComponents.url else {
            return .failure(URLError(.badURL))
        }
        
        return .success(url)
    }
}
