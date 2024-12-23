//
//  UIKitBridge.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 13/12/24.
//

import Foundation
import SwiftUI
import UIKit

struct UIViewControllerWrapper<VC: UIViewController>: UIViewControllerRepresentable {
    // Crear view controller
    let makeUIViewController: () -> VC
    init(makeUIViewController: @escaping () -> VC) {
            self.makeUIViewController = makeUIViewController
            
        }

    func makeUIViewController(context: Context) -> VC {
        return makeUIViewController()
    }

    func updateUIViewController(_ uiViewController: VC, context: Context) {
            // Update the navigation title and right bar button items
           
        }
}

class HostingControllerBuilder {
    
    static func hostingControllerCreateView<Content: View>(
        in parent: UIViewController,
        createFunction: @escaping () -> Content
    ) {
        print("on hosting builder")
        let hostingController = UIHostingController(rootView: createFunction())
        
        parent.addChild(hostingController)
        parent.view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
                
                // Add constraints
                NSLayoutConstraint.activate([
                    hostingController.view.topAnchor.constraint(equalTo: parent.view.topAnchor),
                    hostingController.view.bottomAnchor.constraint(equalTo: parent.view.bottomAnchor),
                    hostingController.view.leadingAnchor.constraint(equalTo: parent.view.leadingAnchor),
                    hostingController.view.trailingAnchor.constraint(equalTo: parent.view.trailingAnchor)
                ])
        
        hostingController.didMove(toParent: parent)
        
        
    }
}
