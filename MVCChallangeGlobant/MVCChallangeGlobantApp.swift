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
            
            MovieViewController.shared.createContentView()
        }
    }
}
