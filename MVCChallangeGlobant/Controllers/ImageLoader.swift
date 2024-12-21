//
//  ImageLoader.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 20/12/24.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    var cancellable: AnyCancellable?
    
    func loadImage(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .tryMap { data -> UIImage? in
                guard let image = UIImage(data: data) else {
                    throw URLError(.badURL)
                }
                return image
            }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
}
