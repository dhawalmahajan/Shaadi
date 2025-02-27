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

    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
