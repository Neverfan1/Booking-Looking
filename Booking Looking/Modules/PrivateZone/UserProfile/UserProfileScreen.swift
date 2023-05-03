//
//  UserProfileScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 23.04.2023.
//

import SwiftUI

struct UserView: View {
    let user: UserModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                photoUser
                fullNameUser
                Divider()
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    emailUser
                    sexUser
                    phoneNumberUser
                    
                }
                .font(.system(size: 18))
            }
            .padding(.horizontal, 30)
        }
        .navigationTitle("Профиль пользователя")
    }
}
extension UserView{
    
    var photoUser: some View{
        Image(systemName: "person.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
            .foregroundColor(user.sex == 0 ? .blue.opacity(0.8) : .pink.opacity(0.8))
        
    }
    
    var fullNameUser: some View{
        Text(user.fullName)
            .font(.title)
            .fontWeight(.bold)
        
    }
    
    var emailUser: some View{
        HStack {
            Text("Email:")
                .fontWeight(.bold)
            Spacer()
            Text(user.email)
        }
    }
    
    var sexUser: some View{
        HStack {
            Text("Пол:")
                .fontWeight(.bold)
            Spacer()
            Text(user.sex == 0 ? "Мужской" : "Женский")
                .font(.subheadline)
        }
        
    }
    
    var phoneNumberUser: some View{
        HStack {
            Text("Телефон:")
                .fontWeight(.bold)
            Spacer()
            Text(user.phoneNumber)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: UserModel(id: 1, email: "example@example.com", name: "Иван", surname: "Иванов", sex: 0, phoneNumber: "89279180443"))
    }
}
