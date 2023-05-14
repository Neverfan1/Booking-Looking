
//
//  RegistrationScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 21.04.2023.
//

import SwiftUI

struct RegistrationView: View {
    
    @StateObject var viewModel: RegistrationViewModel
    
    var body: some View {
        StateView(state: viewModel.output.screenState,
                  content: content)
    }
}

private extension RegistrationView {
    func content() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                topLogo
                phoneNumberUser
                text_phone
                nameUser
                surnameUser
                sexUser
                emailUser
                
                VStack(alignment: .leading) {
                    CheckboxField(
                        label: "Согласие на обработку персональных данных",
                        isChecked: $viewModel.output.isPersonalDataAgreed
                    )
                    CheckboxField(
                        label: "Согласие на отправку писем",
                        isChecked: $viewModel.output.isEmailsAgreed
                    )
                    
                }
                
                AppButton(style: .standart,
                          title: "Зарегистрироваться",
                          action: sendSignUpButton,
                          isButtonEnabled: isFormValid)
            }
            .padding(.top, 50)
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    
    var topLogo: some View {
        Image("logo")
            .renderingMode(.original)
            .resizable()
            .frame(width: UIScreen.main.bounds.width/1.3, height:  UIScreen.main.bounds.height/4.5)
            .padding(.bottom, UIScreen.main.bounds.height/9.4)
    }
    
    
    var phoneNumberUser: some View {
        TextField("Номер телефона",
                  text: $viewModel.output.phoneNumber,
                  onEditingChanged: onFocusPhone)
        .id("phoneNumber")
        .keyboardType(.numberPad)
        .background(isPhoneBgClear ? Color.clear : Color.red.opacity(0.3))
        .textFieldStyle(CustomTextFieldStyle())
        .onChange(of: viewModel.output.phoneNumber,
                  perform: onChangePhone)
    }
    var text_phone: some View {
        Text("Формат телефона для регистрации: 89999999999")
            .font(.subheadline)
            .foregroundColor(.gray.opacity(0.5))
            .padding(.bottom, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 10)
    }
    
    var nameUser: some View {
        TextField("Имя",
                  text: $viewModel.output.name,
                  onEditingChanged: onFocusName)
        .textFieldStyle(CustomTextFieldStyle())
        .background(isNameBgClear ? Color.red.opacity(0.3) : Color.clear)
        .onChange(of: viewModel.output.name,
                  perform: onChangeOfName)
    }
    
    var surnameUser: some View {
        TextField("Фамилия",
                  text: $viewModel.output.surname,
                  onEditingChanged: onFocusSurname)
        .textFieldStyle(CustomTextFieldStyle())
        .background(isSurnameBgClear ? Color.red.opacity(0.3) : Color.clear)
        .onChange(of: viewModel.output.surname,
                  perform: onChangeOfSurname)
    }
    
    var sexUser: some View {
        HStack {
            Text("Пол:")
                .font(.headline)
                .padding(.leading, 20)
                .foregroundColor(.black.opacity(0.6))
            
            Spacer()
            
            Button(action: onMaleTap) {
                HStack {
                    Text("Мужской")
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                }
            }
            .background(viewModel.output.sex == 0 ? Color.black : Color.gray.opacity(0.56))
            .cornerRadius(10)
            .padding(.trailing, 20)
            
            Button(action: onFemaleTap) {
                HStack {
                    Text("Женский")
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                }
            }
            .background(viewModel.output.sex == 1 ? Color.black : Color.gray.opacity(0.56))
            .cornerRadius(10)
            .padding(.trailing, 20)
        }
        .padding(.bottom, 10)
    }
    
    var emailUser: some View {
        TextField("Почта",
                  text: $viewModel.output.email,
                  onCommit: onCommitEmail)
        .keyboardType(.emailAddress)
        .textFieldStyle(CustomTextFieldStyle())
        .background(isEmailBgClear ? Color.clear : Color.red.opacity(0.3))
        .onChange(of: viewModel.output.email,
                  perform: onChangeOfEmail)
    }
}

private extension RegistrationView {
    var isFormValid: Bool {
        isValidPhoneNumber(viewModel.output.phoneNumber) &&
        !viewModel.output.name.isEmpty &&
        !viewModel.output.surname.isEmpty &&
        isValidEmail(viewModel.output.email) &&
        viewModel.output.sex != 2 &&
        viewModel.output.isPersonalDataAgreed &&
        viewModel.output.isEmailsAgreed
    }
    
    var isPhoneBgClear: Bool {
        (isValidPhoneNumber(viewModel.output.phoneNumber) ||
         viewModel.output.phoneNumber.isEmpty) ||
        viewModel.output.hasFocusedPhoneNumber
    }
    
    var isEmailBgClear: Bool {
        isValidEmail(viewModel.output.email) ||
        viewModel.output.email.isEmpty ||
        !viewModel.output.hasFocusedEmail
    }
    
    var isNameBgClear: Bool {
        viewModel.output.hasEnteredName &&
        viewModel.output.name.isEmpty &&
        !viewModel.output.hasFocusedName
    }
    
    var isSurnameBgClear: Bool {
        viewModel.output.hasEnteredSurname &&
        viewModel.output.surname.isEmpty &&
        !viewModel.output.hasFocusedSurname
    }
    
    func onFocusPhone(_ isEditing: Bool) {
        viewModel.output.hasFocusedPhoneNumber = isEditing
    }
    
    func onFocusSurname(_ isEditing: Bool) {
        viewModel.output.hasFocusedSurname = isEditing
        if isEditing {
            viewModel.output.hasEnteredSurname = true
        }
    }
    
    func onFocusName(_ isEditing: Bool) {
        viewModel.output.hasFocusedName = isEditing
        if isEditing {
            viewModel.output.hasEnteredName = true
        }
    }
    
    func onCommitEmail() {
        viewModel.output.hasFocusedEmail = true
    }
}

private extension RegistrationView {
    func sendSignUpButton() {
        viewModel.input.onSignUpTap.send()
    }
    
    func onChangePhone(_ value: String) {
        viewModel.input.onChangePhone.send(value)
    }
    
    func onChangeOfSurname(_ value: String) {
        viewModel.input.onChangeSurname.send(value)
    }
    
    func onChangeOfName(_ value: String) {
        viewModel.input.onChangeName.send(value)
    }
    
    func onMaleTap() {
        viewModel.input.onMaleTap.send(0)
    }
    
    func onFemaleTap() {
        viewModel.input.onFemaleTap.send(1)
    }
    
    func onChangeOfEmail(_ value: String) {
        viewModel.input.onChangeEmail.send(value)
    }
}

#if DEBUG
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(viewModel: RegistrationViewModel(apiService: AuthApiService(),
                                                          router: nil))
    }
}
#endif
