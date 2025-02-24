//
//  CachedImageLoader.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/02/25.
//


import Combine
import SwiftUI

class CachedImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    private var cancellable: AnyCancellable?
    
    func loadImage(from url: String) {
        if let cachedImage = ImageCache.shared.getImage(forKey: url) {
            self.image = cachedImage
            return
        }

        guard let imageUrl = URL(string: url) else { return }

        cancellable = URLSession.shared.dataTaskPublisher(for: imageUrl)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] downloadedImage in
                guard let self = self, let downloadedImage = downloadedImage else { return }
                ImageCache.shared.setImage(downloadedImage, forKey: url)
                self.image = downloadedImage
            })
    }
}
