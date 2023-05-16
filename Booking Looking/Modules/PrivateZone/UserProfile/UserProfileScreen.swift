//
//  UserProfileScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 23.04.2023.
//

import SwiftUI

struct UserView: View {
    
    @StateObject var viewModel: UserProfileViewModel
    
    var body: some View {
        StateView(state: viewModel.output.screenState,
                  onAppear: viewModel.input.onAppear,
                  content: content)
        .navigationTitle("Профиль пользователя")
        .navigationBarTitleDisplayMode(.inline)
    }
}
extension UserView{
    
    func content() -> some View {
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
                Spacer()
                exitButton
            }
            .padding(.horizontal, 30)
        }
    }
    
    var photoUser: some View{
        Image(systemName: "person.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
            .foregroundColor(viewModel.output.user.sex == 0 ? .blue.opacity(0.8) : .pink.opacity(0.8))
        
    }
    
    var fullNameUser: some View{
        Text(viewModel.output.user.fullName)
            .font(.title)
            .fontWeight(.bold)
        
    }
    
    var emailUser: some View{
        HStack {
            Text("Email:")
                .fontWeight(.bold)
            Spacer()
            Text(viewModel.output.user.email)
        }
    }
    
    var sexUser: some View{
        HStack {
            Text("Пол:")
                .fontWeight(.bold)
            Spacer()
            Text(viewModel.output.user.sex == 0 ? "Мужской" : "Женский")
                .font(.subheadline)
        }
        
    }
    
    var phoneNumberUser: some View{
        HStack {
            Text("Телефон:")
                .fontWeight(.bold)
            Spacer()
            Text(viewModel.output.user.phoneNumber)
        }
    }
    
    var exitButton: some View {
        AppButton(style: .exit,
                  title: "Выйти",
                  action: { viewModel.input.onExitTap.send() },
                  isButtonEnabled: true)
    }
}

#if DEBUG
import Combine
struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(viewModel: UserProfileViewModel(apiService: UserApiService(), authState: CurrentValueSubject<AuthState, Never>(.authorized)))
    }
}
#endif
