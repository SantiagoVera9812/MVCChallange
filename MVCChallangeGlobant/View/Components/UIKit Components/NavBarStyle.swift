//
//  NavBarStyle.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 13/12/24.
//

import Foundation
import UIKit

protocol NavigationBarStyle {
    func configure(_ viewController: UIViewController)
}

struct NavigationBarHide: NavigationBarStyle {
    func configure(_ viewController: UIViewController) {
        viewController.navigationController?.isNavigationBarHidden = true
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                          style: .plain,
                                                                          target: nil,
                                                                          action: nil)
    }
}

struct NavigationBarSimpleShow: NavigationBarStyle {
    func configure(_ viewController: UIViewController) {
        viewController.navigationController?.isNavigationBarHidden = false
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                          style: .plain,
                                                                          target: nil,
                                                                          action: nil)
        viewController.navigationController?.navigationBar.tintColor = .black
    }
}

struct NavigationBarTitle: NavigationBarStyle {
    
    private let title: String
    
    init(title: String) {
        self.title = title
    }
    
    func configure(_ viewController: UIViewController) {
        viewController.title = self.title
        viewController.navigationController?.isNavigationBarHidden = false
        viewController.navigationItem.hidesBackButton = true
        viewController.navigationController?.navigationBar.tintColor = .black
    }
}

struct NavigationBarWithRightButton: NavigationBarStyle {
    
    private let title: String
    private let rightButtonTitle: String
    
    init(title: String, rightButtonTitle: String) {
        self.title = title
        self.rightButtonTitle = rightButtonTitle
    }
    
    func configure(_ viewController: UIViewController) {
        
        
        viewController.title = self.title
        viewController.navigationController?.isNavigationBarHidden = false
        viewController.navigationController?.navigationBar.tintColor = .black
        viewController.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = backButton
        
        // Create the right button
        let rightButton = UIBarButtonItem(title: rightButtonTitle, style: .plain, target: self, action: nil)
        viewController.navigationItem.rightBarButtonItem = rightButton
    }
    
}

struct NavigationBarWithImageAsAButton: NavigationBarStyle {
    
    let title: String
    var rightButtonImage: UIImage?

    func configure(_ viewController: UIViewController) {
        
        viewController.navigationItem.title = title
        
        if let image = rightButtonImage {
            let rightButton = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
            viewController.navigationItem.rightBarButtonItem = rightButton
        }
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = backButton
        
    }
}
