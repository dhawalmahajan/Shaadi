//
//  CachedImageView.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/02/25.
//


import SwiftUI

struct CachedImageView: View {
    @StateObject private var loader = CachedImageLoader()
    let url: String

    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .onAppear {
                        loader.loadImage(from: url)
                    }
            }
        }
    }
}
