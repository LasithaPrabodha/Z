//
//  RegistrationView.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var username = ""
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("letter-z")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            VStack{
                TextField("Enter your email", text: $email)
                    .modifier(ZTextFieldModifier())
                
                SecureField("Enter your password", text:  $password)
                    .modifier(ZTextFieldModifier())
                
                TextField("Enter your full name", text: $fullname)
                    .modifier(ZTextFieldModifier())
                
                TextField("Enter your username", text: $username)
                    .modifier(ZTextFieldModifier())
                
            }
            
            Button {
                
            } label: {
                Text("Sign Up")
                    .modifier(ZPrimaryButtonModifier())
            }
            .padding(.vertical)
            
            Spacer()
            
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3){
                    Text("Already have an account?")
                    
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.black)
                .font(.footnote)
            }
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    RegistrationView()
}
