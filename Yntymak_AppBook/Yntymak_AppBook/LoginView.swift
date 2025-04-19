//
//  LoginView.swift
//  Yntymak_AppBook
//
//  Created by Smart Castle M1A2007 on 19.04.2025.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            MainView()
        } else {
            VStack(spacing: 20) {
                Text("Добро пожаловать!")
                    .font(.largeTitle)
                    .bold()

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField("Пароль", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    // Простейшая авторизация
                    if !email.isEmpty && !password.isEmpty {
                        isLoggedIn = true
                    }
                }) {
                    Text("Войти")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(email.isEmpty || password.isEmpty)
                .padding(.top, 10)
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
