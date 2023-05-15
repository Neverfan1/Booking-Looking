//
//  AuthorizationScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 21.04.2023.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: AuthorizationViewModel
    
    var body: some View {
        StateView(state: viewModel.output.screenState,
                  content: content)
    }
}

private extension LoginView {
    func content() -> some View {
        VStack {
            topLogo
            emailField
            
            AppButton(style: .standart,
                      title: "Войти",
                      action: onSignInTap,
                      isButtonEnabled: isFormValid)
            
            AppButton(style: .standart,
                      title: "Регистрация",
                      action: onSignUpTap,
                      isButtonEnabled: true)
        }
    }
    
    var topLogo: some View{
        Image("logo")
            .renderingMode(.original)
            .resizable()
            .frame(width: UIScreen.main.bounds.width/1.3, height:  UIScreen.main.bounds.height/4.5)
            .padding(.bottom, UIScreen.main.bounds.height/5.6)
    }
    
    var emailField: some View{
        TextField("E-mail", text: $viewModel.output.email)
            .textFieldStyle(CustomTextFieldStyle())
            .padding(.bottom, 20)
            .onChange(of: viewModel.output.email,
                      perform: onChangeOfEmail)
    }
}

private extension LoginView {
    var isFormValid: Bool {
        isValidEmail(viewModel.output.email)
    }
    
    func onChangeOfEmail(_ value: String) {
        viewModel.input.onChangeEmail.send(value)
    }
    
    func onSignInTap() {
        viewModel.input.onSignInTap.send()
    }
    
    func onSignUpTap() {
        viewModel.router?.pushToRegister()
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: AuthorizationViewModel(apiService: AuthApiService(),
                                                    router: nil))
    }
}
#endif

