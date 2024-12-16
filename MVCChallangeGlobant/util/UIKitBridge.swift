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
        let hostingController = UIHostingController(rootView: createFunction())
        let navigationController = UINavigationController(rootViewController: parent)
        
        parent.addChild(hostingController)
        parent.view.addSubview(hostingController.view)
        
        hostingController.view.frame = parent.view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        hostingController.didMove(toParent: parent)
        
        
    }
}
