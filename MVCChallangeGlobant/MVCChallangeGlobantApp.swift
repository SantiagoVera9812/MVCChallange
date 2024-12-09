//
//  MVCChallangeGlobantApp.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 27/11/24.
//

import SwiftUI

@main
struct MVCChallangeGlobantApp: App {
    var body: some Scene {
        WindowGroup {
            
        
                            ViewControllerWrapper()
        }
    }
}

struct ViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> MovieViewController {
        let movie = MovieViewController()
        
                return movie
    }
    
    func updateUIViewController(_ uiViewController: MovieViewController, context: Context) {
        // Update the view controller if needed
    }
}

struct DetailsControllerWrapper: UIViewControllerRepresentable {
    
    let movieId: Int
    
    func makeUIViewController(context: Context) -> MovieDetailViewController {
        let movie = MovieDetailViewController(movieID: movieId)
        
                return movie
    }
    
    func updateUIViewController(_ uiViewController: MovieDetailViewController , context: Context) {
        // Update the view controller if needed
    }
    
    
    
}
