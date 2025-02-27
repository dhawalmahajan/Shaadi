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
    /// Constructs a URL with the specified query parameters for fetching paginated results.
    ///
    /// This function takes the number of results per page and the current page number,
    /// then appends them as query parameters to the base API URL.
    /// If the URL is invalid, it returns a failure result.
    ///
    /// - Parameters:
    ///   - results: The number of results to fetch per page.
    ///   - page: The page number for pagination.
    ///
    /// - Returns: A `Result<URL, URLError>` containing either the constructed `URL`
    ///            or an `URLError` if URL formation fails.
    ///
    /// - Example:
    /// ```swift
    /// let urlResult = apiURLBuilder.buildURL(results: 10, page: 2)
    /// switch urlResult {
    /// case .success(let url):
    ///     print("Generated URL: \(url)")
    /// case .failure(let error):
    ///     print("Failed to generate URL: \(error)")
    /// }
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
