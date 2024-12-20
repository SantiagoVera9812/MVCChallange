//
//  TapBarController.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 16/12/24.
//

import Foundation
import UIKit


class TabBarController: UITabBarController {
    
    let navigationStyle: NavigationBarStyle
    
    init(controllers: [UIViewController], navigationStyle: NavigationBarStyle) {
        self.navigationStyle = navigationStyle
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = controllers
        self.tabBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationStyle.configure(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TabBarController {
    
    class func buildCars() -> TabBarController {
        let controllers = [MovieGridViewController.buildSimpleList(), MovieGridViewController.buildGridList()]
        let navStyle = NavigationBarWithRightButton(title: "Movies", rightButtonTitle: "Settings")
        let controller = TabBarController(controllers: controllers, navigationStyle: navStyle)
        return controller
    }
}
