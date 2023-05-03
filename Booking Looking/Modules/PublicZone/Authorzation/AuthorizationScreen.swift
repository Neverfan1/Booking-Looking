//
//  AuthorizationScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 21.04.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    
    private var isFormValid: Bool {
        isValidEmail(email)
    }
    
    var body: some View {
        VStack {
            topLogo
            emailField
            
            AppButton(style: .standart, title: "Войти", action: {}, isButtonEnabled: isFormValid)
            AppButton(style: .standart, title: "Регистрация", action: {}, isButtonEnabled: true)
        }
    }
}

extension LoginView{
    var topLogo: some View{
        Image("logo")
            .renderingMode(.original)
            .resizable()
            .frame(width: UIScreen.main.bounds.width/1.3, height:  UIScreen.main.bounds.height/4.5)
            .padding(.bottom, UIScreen.main.bounds.height/5.6)
    }
    
    var emailField: some View{
        TextField("Email", text: $email)
            .textFieldStyle(CustomTextFieldStyle())
            .padding(.bottom, 20)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

