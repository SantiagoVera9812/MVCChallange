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
