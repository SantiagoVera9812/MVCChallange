//
//  MoviePosterView.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 30/11/24.
//

import Foundation
import SwiftUI

struct AsyncImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    let posterPath: String

    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(8)
                    .frame(width: 100, height: 150)
            } else {
                ProgressView()
                    .frame(width: 100, height: 150)
            }
        }
        .onAppear {
            if let url = Constants.Urls.urlForMoviePoster(poster_path: posterPath) {
                imageLoader.loadImage(from: url)
            }
        }
    }
}

struct MoviePosterView: View {
    let posterPath: String

    var body: some View {
        AsyncImageView(posterPath: posterPath)
    }
}
