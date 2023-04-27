//
//  ChekBox.swift
//  Booking Looking
//
//  Created by Данила Парамин on 22.04.2023.
//

import SwiftUI

struct CheckboxField: View {
    let label: String
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: {
            self.isChecked.toggle()
        }) {
            VStack(alignment: .leading){
                HStack(alignment: .center, spacing: 10) {
                    Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    Text(label)
                        .foregroundColor(.primary)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                    
                        
                }
            }
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(.primary)
        .padding(.vertical, 4)
    }
}

struct CheckboxField_Previews: PreviewProvider {
    @State static var test: Bool = true
    
    static var previews: some View {
        CheckboxField(label: "Длинный текст, который может не поместиться на одной строке", isChecked: $test)
    }
}





//
////
////  RegistrationScreen.swift
////  Booking Looking
////
////  Created by Данила Парамин on 21.04.2023.
////
//
//import SwiftUI
//
//struct RegistrationView: View {
//    @State private var phoneNumber: String = ""
//    @State private var name: String = ""
//    @State private var surname: String = ""
//    @State private var sex: Int? = nil
//    @State private var email: String = ""
//    @State private var isPersonalDataAgreed: Bool = false
//    @State private var isEmailsAgreed: Bool = false
//    
//    @State private var hasFocusedPhoneNumber: Bool = false
//    @State private var hasFocusedName: Bool = false
//    @State private var hasFocusedSurname: Bool = false
//    @State private var hasFocusedEmail: Bool = false
//    
//    private var isFormValid: Bool {
//        isValidPhoneNumber(phoneNumber) &&
//        isValidNameOrSurname (name) &&
//        isValidNameOrSurname(surname) &&
//        isValidEmail(email) &&
//        sex != nil &&
//        isPersonalDataAgreed &&
//        isEmailsAgreed
//    }
//    
//    var body: some View {
//        VStack {
//            topLogo
//            ScrollView(.vertical, showsIndicators: false) {
//                phoneNumberUser
//                nameUser
//                surnameUser
//                sexUser
//                emailUser
//                VStack(alignment: .leading) {
//                    CheckboxField(
//                        label: "Согласие на обработку персональных данных",
//                        isChecked: $isPersonalDataAgreed
//                    )
//                    CheckboxField(
//                        label: "Согласие на отправку писем",
//                        isChecked: $isEmailsAgreed
//                    )
//                    
//                }
//                AppButton(style: .authorization, title: "Зарегистрироваться", action: {}, isButtonEnabled: isFormValid)
//            }
//            .padding(.top, 50)
//            .edgesIgnoringSafeArea(.all)
//        }
//    }
//}
//
//extension RegistrationView{
//    
//    var topLogo: some View{
//        Image("logo")
//            .renderingMode(.original)
//            .resizable()
//            .frame(width: 250, height: 200)
//    }
//    
//    var phoneNumberUser: some View {
//        TextField("Номер телефона", text: $phoneNumber,
//                  onCommit: {
//                              hasFocusedPhoneNumber = true
//                          })
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//            .padding(.horizontal, 20)
//            .padding(.bottom, 20)
//            .background((isValidPhoneNumber(phoneNumber) || phoneNumber.isEmpty) || !hasFocusedPhoneNumber ? Color.clear : Color.red.opacity(0.3))
//
//    }
//    
//    var nameUser: some View{
//        TextField("Имя", text: $name,
//                  onCommit: {
//                              hasFocusedName = true
//                          })
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//            .padding(.horizontal, 20)
//            .padding(.bottom, 20)
//            .background(isValidNameOrSurname(name) ? Color.clear : Color.red.opacity(0.3))
//    }
//    
//    var surnameUser: some View{
//        TextField("Фамилия", text: $surname,
//                  onCommit: {
//                              hasFocusedSurname = true
//                          })
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//            .padding(.horizontal, 20)
//            .padding(.bottom, 20)
//            .background(isValidNameOrSurname(surname) ? Color.clear : Color.red.opacity(0.3))
//    }
//    
//    var sexUser: some View{
//        HStack {
//            Text("Пол:")
//                .font(.headline)
//                .padding(.leading, 20)
//                .foregroundColor(.black.opacity(0.6))
//            Spacer()
//            
//            Button(action: {
//                self.sex = 0
//            }) {
//                HStack {
//                    Text("Мужской")
//                        .foregroundColor(.white)
//                        .padding(.horizontal, 10)
//                        .padding(.vertical, 5)
//                    
//                }
//            }
//            .background(sex == 0 ? Color.black : Color.gray.opacity(0.2))
//            .cornerRadius(10)
//            .padding(.trailing, 20)
//            
//            Button(action: {
//                self.sex = 1
//            }) {
//                HStack {
//                    Text("Женский")
//                        .foregroundColor(.white)
//                        .padding(.horizontal, 10)
//                        .padding(.vertical, 5)
//                    
//                }
//            }
//            .background(sex == 1 ? Color.black : Color.gray.opacity(0.2))
//            .cornerRadius(10)
//            .padding(.trailing, 20)
//        }
//        .padding(.bottom, 10)
//    }
//    
//    var emailUser: some View{
//        TextField("Почта", text: $email,
//                  onCommit: {
//                              hasFocusedEmail = true
//                          })
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//            .padding(.horizontal, 20)
//            .padding(.bottom, 20)
//            .background(isValidEmail(email) || email.isEmpty ? Color.clear : Color.red.opacity(0.3))
//
//    }
//}
//
//struct RegistrationView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegistrationView()
//    }
//}
//
//
//private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
//    let pattern = "^8\\d{10}$"
//    let regex = try? NSRegularExpression(pattern: pattern, options: [])
//    return regex?.firstMatch(in: phoneNumber, options: [], range: NSRange(location: 0, length: phoneNumber.count)) != nil
//}
//
//private func isValidNameOrSurname(_ name: String) -> Bool {
//    return !name.isEmpty
//}
//
//private func isValidEmail(_ email: String) -> Bool {
//    let pattern = "^[^@]+@[^@]+\\.(ru|com)$"
//    let regex = try? NSRegularExpression(pattern: pattern, options: [])
//    return regex?.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil
//}
