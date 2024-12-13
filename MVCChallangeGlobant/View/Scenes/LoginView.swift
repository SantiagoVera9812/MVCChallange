//
//  LoginView.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 11/12/24.
//

import SwiftUI

protocol LoginViewDelegate: AnyObject {
    func loginViewSignUp(_ view: LoginView)
    func loginViewRecoverPassword(_ view: LoginView)
}

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    weak var delegate: LoginViewDelegate?
    
    var body: some View {
        VStack(spacing: 20) {
            headerView
            
            VStack(spacing: 5) {
                Text("Correo:")
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        // Move to password field
                    }
            }
            
            VStack(spacing: 5) {
                Text("Contraseña:")
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
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Button(action: {
                delegate?.loginViewSignUp(self)
            }) {
                Text("Regístrate aquí")
                    .foregroundColor(.blue)
            }
            
            Button(action: {
                delegate?.loginViewRecoverPassword(self)
            }) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("¿Olvidaste tu contraseña?")
                }
                .foregroundColor(.blue)
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
    
    private var headerView: some View {
        VStack {
            Image(systemName: "person.fill") // Replace with your image
                .resizable()
                .frame(width: 60, height: 60)
                .background(Color.red)
                .clipShape(Circle())
                .padding()
                .background(Color.green)
                .clipShape(Circle())
        }
    }
    
    private func doSignIn() {
        // Implement sign-in logic here
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
