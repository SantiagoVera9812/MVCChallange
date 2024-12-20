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
    
    let registerService: enterAppDelegate
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(registerService: enterAppDelegate = CoreDataService()) {
        
        self.registerService = registerService
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
        
        
        guard registerService.loginUser(email: user, password: password) != nil else {return self.showErrorAlertWithMessage("Uusario no encontrado")}
        
        let movieViewController = TabBarController.buildCars()
            self.navigationController?.pushViewController(movieViewController, animated: true)
        
    }
    
    
    
    func loginViewSignUp(_ view: LoginView) {
        
        let registerController = RegisterController()
        
        let navBarStyle = NavigationBarTitle(title: "Register")
        
        navBarStyle.configure(registerController)
        
        self.navigationController?.pushViewController(registerController, animated: true)
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


