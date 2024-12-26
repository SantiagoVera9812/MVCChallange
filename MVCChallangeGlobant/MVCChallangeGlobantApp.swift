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
            
            
            UIViewControllerWrapper {
                let loginViewController = LoginViewController()
                let navigationController = CustomNavigationController(rootViewController: loginViewController)
                
                return navigationController
            }
        }
    }
}

class CustomNavigationController: UINavigationController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let window = self.view.window {
            let safeAreaInsets = window.safeAreaInsets
            var newFrame = window.bounds
            newFrame.origin.y = -safeAreaInsets.top 
            newFrame.size.height += safeAreaInsets.top
            
            self.view.frame = newFrame
        }
    }
}

// Generic UIViewController Wrapper




