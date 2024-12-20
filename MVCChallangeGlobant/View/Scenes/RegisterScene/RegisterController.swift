//
//  RegisterController.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 20/12/24.
//

import SwiftUI
import UIKit
import Foundation

protocol RegisterUserDelegate: AnyObject{
    
    func registerUser(didRegisterWith: String?, andPassword: String?)
    
}

class RegisterController: UIViewController {
    
    let registerService: enterAppDelegate
    
    
    init(registerService: enterAppDelegate = CoreDataService()){
        
        self.registerService = registerService
        
        super.init(nibName: nil, bundle: nil)
        
        HostingControllerBuilder.hostingControllerCreateView(in: self) {
                    // Replace this with your actual SwiftUI view
            self.createRegisterView()
                }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension RegisterController{
    func createRegisterView() -> some View {
        
        var registerView = RegisterView()
        registerView.delegate = self
        
            return AnyView(
                registerView
            )
    }
}

extension RegisterController: RegisterUserDelegate {
    
    func registerUser(didRegisterWith user: String?, andPassword password: String?) {
        
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
        
        guard registerService.loginUser(email: user, password: password) != nil else {
            registerService.registerUser(email: user, password: password)
            
            let hostingController = LoginViewController()
            let navBarStyle = NavigationBarTitle(title: "Login")
            navBarStyle.configure(hostingController)
            self.navigationController?.pushViewController(hostingController, animated: true)
            
            return
        }
        
        self.showErrorAlertWithMessage("Ya hay un usuario con esas credenciales")
        
        
    }

}


