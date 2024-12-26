//
//  RegisterView.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 20/12/24.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    weak var delegate: RegisterUserDelegate?
    
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
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 20) {
                
                //            headerView
                
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
                    Text("Registrarse")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(20)
            }
        }
        
        private func doSignIn() {
            
            delegate?.registerUser(didRegisterWith: email, andPassword: password)
            
        }
        
        
    
}

#Preview {
    RegisterView()
}
