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
            
        
            UIViewControllerWrapper{
                let loginViewController = LoginViewController()
                let navigationController = UINavigationController(rootViewController: loginViewController)
                
                return navigationController
                                                                
                                                                      
            }
        }
    }
}

// Generic UIViewController Wrapper




