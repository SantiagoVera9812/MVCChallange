//
//  LoginView.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 11/12/24.
//

import SwiftUI

protocol LoginViewDelegate: AnyObject {
    func loginViewLogin(_ view: LoginView, didSignInWith user: String?, andPassword password: String?)
    func loginViewSignUp(_ view: LoginView)
    func loginViewRecoverPassword(_ view: LoginView)
}

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    
    weak var delegate: LoginViewDelegate?
    
    var body: some View {
        
        ZStack{
            AppTheme.AppColors.background.ignoresSafeArea(.all)
            
            VStack(spacing: 60) {
        
                //            headerView
                
                VStack(spacing: 5) {
                    Text("Correo:")
                        .foregroundColor(AppTheme.AppColors.text)
                        .fontWeight(.heavy)
                    TextField("Email", text: $email)
                        .background(AppTheme.AppColors.textFields)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            // Move to password field
                        }
                }
                
                VStack(spacing: 5) {
                    Text("Contraseña:")
                        .foregroundColor(AppTheme.AppColors.text)
                        .fontWeight(.heavy)
                    SecureField("Contraseña", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            doSignIn()
                        }
                }
                
                Button(action: doSignIn) {
                    Text("INICIAR SESIÓN")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.AppColors.buttonBackground)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: doSignUp) {
                    Text("Regístrate aquí")
                        .foregroundColor(AppTheme.AppColors.buttonBackground)
                    
                }
                
                Button(action: doRecoverPassword) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("¿Olvidaste tu contraseña?")
                    }
                    .foregroundColor(AppTheme.AppColors.buttonBackground)
                }
            }
            .padding(20)
            //        .background(Color.white)
            //        .cornerRadius(12)
            //        .shadow(radius: 10)
        }
    }
    
    private func doRecoverPassword(){
        delegate?.loginViewRecoverPassword(self)
    }
    
    private func doSignUp(){
        delegate?.loginViewSignUp(self)
    }
    
    private func doSignIn() {
        
        delegate?.loginViewLogin(self, didSignInWith: email, andPassword: password)
    }
}



#Preview {
    
    UIViewControllerWrapper{
        let loginViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        
        return navigationController
                                                        
                                                              
    }
}
