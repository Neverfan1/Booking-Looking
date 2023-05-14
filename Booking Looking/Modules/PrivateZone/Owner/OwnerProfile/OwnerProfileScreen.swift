//
//  OwnerProfileScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 15.05.2023.
//

import SwiftUI

struct OwnerProfileScreen: View {
    let owner: OwnerModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                photoOwner
                nameOwner
                Divider()
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    descriptionOwner
                    contactOwner
                    
                }
                .font(.system(size: 18))
                
                AppButton(style: .standart, title: "Все жилища хозяина", action: {
                    
                }, isButtonEnabled: true)
                .padding(.top, 50)
            }
            .padding(.horizontal, 30)
        }
        .navigationTitle("Профиль пользователя")
    }
}
extension OwnerProfileScreen{
    
    var photoOwner: some View {
        if owner.image == "null" {
            return AnyView(
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            )
        } else {
            return AnyView(
                NetworkImage(imageURL: URL(string: owner.image),
                             width: UIScreen.main.bounds.width / 1.2,
                             height: UIScreen.main.bounds.height / 4,
                             cornerRadius: 10)
            )
        }
    }

    var nameOwner: some View{
        Text(owner.name)
            .font(.title)
            .fontWeight(.bold)
        
    }
    
    
    var descriptionOwner: some View{
        HStack {
            Text("Описание:")
                .fontWeight(.bold)
            Spacer()
            Text(owner.description)
        }
    }
    
    
    var contactOwner: some View{
        HStack {
            Text("Телефон:")
                .fontWeight(.bold)
            Spacer()
            Text(owner.contact)
        }
    }
}

struct OwnerProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        OwnerProfileScreen(owner: OwnerModel.mock())
    }
}

