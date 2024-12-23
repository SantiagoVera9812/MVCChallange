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
    var loginUser: AnyObject
    weak var updateDelegate: MovieDetailUpdateDelegate?
    var preferredLanguage: String
    var typeView: ViewType
    
    init(controllers: [UIViewController], navigationStyle: NavigationBarStyle, loginUser: AnyObject, preferredLanguage: String = "en", typeView: ViewType = .grid) {
        self.loginUser = loginUser
        self.navigationStyle = navigationStyle
        self.preferredLanguage = preferredLanguage
        print("preferred language: \(preferredLanguage)")
        self.typeView = typeView
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

extension TabBarController: MovieDetailUpdateDelegate {
    
    func didUpdateLoginUser(_ user: AnyObject) {
        self.loginUser = user
        updateDelegate?.didUpdateLoginUser(self.loginUser)
        print("set login user on tab bar controller \(self.loginUser)")
    }
    
    
    class func buildCars(onLoginUser: AnyObject, language: String = "en", viewType: ViewType = .grid) -> TabBarController {
        
        print("language on build cars \(language)")
        
        let controllers = createViewControllers(for: viewType, onLoginUser: onLoginUser, language: language)
                
        let controller = TabBarController(controllers: controllers, navigationStyle: NavigationBarWithRightButton(title: "Movies", rightButtonTitle: "Settings"), loginUser: onLoginUser)
                
                // Set the right button action after the instance is created
                if let navStyle = controller.navigationStyle as? NavigationBarWithRightButton {
                    navStyle.rightButtonAction = {
                        let sidebarVC = SidebarViewController()
                        sidebarVC.delegate = controller // Set the delegate
                        controller.navigationController?.pushViewController(sidebarVC, animated: true)
                    }
                }
        
        return controller
    }
}

extension TabBarController {
    
    private class func createViewControllers(for viewType: ViewType, onLoginUser: AnyObject, language: String) -> [UIViewController] {
        switch viewType {
        case .grid:
            let gridListController = MovieViewController.buildGridList(onLoginUser: onLoginUser, language: language)
            let searchViewControllerGrid = MovieSearchViewController.buildGridList(loginUser: onLoginUser, language: language)
            return [gridListController, searchViewControllerGrid]
            
        case .simple:
            let simpleListController = MovieViewController.buildSimpleList(onLoginUser: onLoginUser, language: language)
            let searchViewControllerList = MovieSearchViewController.buildSimpleList(loginUser: onLoginUser, language: language)
            return [simpleListController, searchViewControllerList]
        }
    }
}
extension TabBarController: SidebarViewControllerDelegate{
    
    func didChangeLanguage(to language: String) {
        
        let movieViewController = TabBarController.buildCars(onLoginUser: loginUser, language: language, viewType: typeView)
        
            self.navigationController?.pushViewController(movieViewController, animated: true)
        print("changed to \(language)")
    }
    
    func didChangeView(to viewType: ViewType) {
        
        self.typeView = viewType
        
        let movieViewController = TabBarController.buildCars(onLoginUser: loginUser, language: self.preferredLanguage, viewType: typeView)
        
            self.navigationController?.pushViewController(movieViewController, animated: true)
        print("changed to \(self.typeView)")
        
    }

}

enum ViewType {
    
    case grid
    case simple
}
