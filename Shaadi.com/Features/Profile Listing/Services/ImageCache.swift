//
//  ImageCache.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/02/25.
//

import SwiftUI
class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    /// Retrieves a cached image for the given key.
    ///
    /// This function looks up an image stored in the in-memory cache
    /// and returns it if available.
    ///
    /// - Parameter key: A unique identifier for the image.
    /// - Returns: The cached `UIImage` if it exists, otherwise `nil`.
    ///
    /// - Example:
    /// ```swift
    /// if let cachedImage = imageCache.getImage(forKey: "profile_pic") {
    ///     imageView.image = cachedImage
    /// }
    /// ```
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    
    /// Stores an image in the cache with a specified key.
    ///
    /// This function saves the given image in an in-memory cache
    /// using the provided key for quick retrieval.
    ///
    /// - Parameters:
    ///   - image: The `UIImage` to be stored in the cache.
    ///   - key: A unique identifier for the image.
    ///
    /// - Example:
    /// ```swift
    /// imageCache.setImage(profileImage, forKey: "profile_pic")
    /// ```
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
