//
//  LoginViewController.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 11/12/24.
//

import Foundation
import UIKit
import SwiftUI

class LoginViewController: UIViewController, LoginViewDelegate{
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
        HostingControllerBuilder.hostingControllerCreateView(in: self) {
                    // Replace this with your actual SwiftUI view
            self.createLoginView()
                }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = self.navigationController {
                print("Navigation Controller found: \(navigationController.description)")
                navigationController.navigationBar.topItem?.title = "Login"
                navigationController.navigationBar.topItem?.rightBarButtonItems = [UIBarButtonItem(title: "Help", style: .plain, target: nil, action: nil)]
            } else {
                print("No navigation controller found.")
            }
        
    }
    
    
    func loginViewLogin(_ view: LoginView, didSignInWith user: String?, andPassword password: String?) {
        
        guard let user = user, !user.isEmpty else {
            print("no user")
            self.showErrorAlertWithMessage("Ingresa un usuario")
            return
        }
        
        guard let password = password, !password.isEmpty else {
            print("no contrasena")
            self.showErrorAlertWithMessage("Ingresa una constraseña")
            return
        }
        
        print("complete user made")
        let movieViewController = MovieViewController()
            self.navigationController?.pushViewController(movieViewController, animated: true)
        
    }
    
    
    
    func loginViewSignUp(_ view: LoginView) {
        print("sign up pressed")
    }
    
    func loginViewRecoverPassword(_ view: LoginView) {
        print("password recovery pressed")
    }
    
    
}

extension LoginViewController {
    
    
    
    func createLoginView() -> some View {
            var loginView = LoginView()
            loginView.delegate = self
            
            return AnyView(loginView)
        }
}

class ContainerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create your LoginViewController
        let loginViewController = LoginViewController()
        
        // Wrap it in a UINavigationController
        let navigationController = UINavigationController(rootViewController: loginViewController)
        
        // Present the navigation controller
        self.present(navigationController, animated: true, completion: nil)
    }
}
