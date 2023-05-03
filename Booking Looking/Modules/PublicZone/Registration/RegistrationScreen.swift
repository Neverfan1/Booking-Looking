
//
//  RegistrationScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 21.04.2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var phoneNumber: String = ""
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var sex: Int? = nil
    @State private var email: String = ""
    @State private var isPersonalDataAgreed: Bool = false
    @State private var isEmailsAgreed: Bool = false
    
    @State private var hasFocusedPhoneNumber: Bool = false
    @State private var hasFocusedName: Bool = false
    @State private var hasFocusedSurname: Bool = false
    @State private var hasFocusedEmail: Bool = false
    
    @State private var hasEnteredName = false
    @State private var hasEnteredSurname = false
    
    
    private var isFormValid: Bool {
        isValidPhoneNumber(phoneNumber) &&
        !name.isEmpty &&
        !surname.isEmpty &&
        isValidEmail(email) &&
        sex != nil &&
        isPersonalDataAgreed &&
        isEmailsAgreed
    }
    
    var body: some View {
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
                        isChecked: $isPersonalDataAgreed
                    )
                    CheckboxField(
                        label: "Согласие на отправку писем",
                        isChecked: $isEmailsAgreed
                    )
                    
                }
                AppButton(style: .standart, title: "Зарегистрироваться", action: {}, isButtonEnabled: isFormValid)
            }
            .padding(.top, 50)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

extension RegistrationView{
    
    var topLogo: some View{
        Image("logo")
            .renderingMode(.original)
            .resizable()
            .frame(width: UIScreen.main.bounds.width/1.3, height:  UIScreen.main.bounds.height/4.5)
            .padding(.bottom, UIScreen.main.bounds.height/9.4)
        
    }
    
    
    var phoneNumberUser: some View {
        TextField("Номер телефона", text: $phoneNumber) { isEditing in
            hasFocusedPhoneNumber = isEditing
        }
        .id("phoneNumber")
        .keyboardType(.numberPad)
        .background((isValidPhoneNumber(phoneNumber) || phoneNumber.isEmpty) || hasFocusedPhoneNumber ? Color.clear : Color.red.opacity(0.3))
        .textFieldStyle(CustomTextFieldStyle())
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
    
    var nameUser: some View{
        TextField("Имя", text: $name)
        { isEditing in
            hasFocusedName = isEditing
            if isEditing {
                hasEnteredName = true
            }
        }
        
        .textFieldStyle(CustomTextFieldStyle())
        .background(hasEnteredName && name.isEmpty && !hasFocusedName ? Color.red.opacity(0.3) : Color.clear)
    }
    
    var surnameUser: some View{
        TextField("Фамилия", text: $surname)
        { isEditing in
            hasFocusedSurname = isEditing
            if isEditing {
                hasEnteredSurname = true
            }
        }
        .textFieldStyle(CustomTextFieldStyle())
        .background(hasEnteredSurname && surname.isEmpty && !hasFocusedSurname ? Color.red.opacity(0.3) : Color.clear)
    }
    
    var sexUser: some View{
        HStack {
            Text("Пол:")
                .font(.headline)
                .padding(.leading, 20)
                .foregroundColor(.black.opacity(0.6))
            Spacer()
            
            Button(action: {
                self.sex = 0
            }) {
                HStack {
                    Text("Мужской")
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                    
                }
            }
            .background(sex == 0 ? Color.black : Color.gray.opacity(0.56))
            .cornerRadius(10)
            .padding(.trailing, 20)
            
            Button(action: {
                self.sex = 1
            }) {
                HStack {
                    Text("Женский")
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                    
                }
            }
            .background(sex == 1 ? Color.black : Color.gray.opacity(0.56))
            .cornerRadius(10)
            .padding(.trailing, 20)
        }
        .padding(.bottom, 10)
    }
    
    var emailUser: some View{
        TextField("Почта", text: $email,
                  onCommit: {
            hasFocusedEmail = true
        })
        .keyboardType(.emailAddress)
        .textFieldStyle(CustomTextFieldStyle())
        .background(isValidEmail(email) || email.isEmpty || !hasFocusedEmail ? Color.clear : Color.red.opacity(0.3))
        
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
