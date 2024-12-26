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
        
        print("on login view")
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
        
        
        guard let loginUser = registerService.loginUser(email: user, password: password) else {return self.showErrorAlertWithMessage("Uusario no encontrado")}
        
        if let preferredLanguage = Locale.preferredLanguages.first {

            let languageCode = String(preferredLanguage.prefix(2))
            print("Preferred language code: \(languageCode)")
            
            let movieViewController = TabBarController.buildCars(onLoginUser: loginUser, language: languageCode)
            
                self.navigationController?.pushViewController(movieViewController, animated: true)
        } else {
            
            let movieViewController = TabBarController.buildCars(onLoginUser: loginUser)
                self.navigationController?.pushViewController(movieViewController, animated: true)
        }
        
        
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
        print("login view")
        
        
            var loginView = LoginView()
            loginView.delegate = self
            
        return AnyView(
            loginView
        )
        }
}


