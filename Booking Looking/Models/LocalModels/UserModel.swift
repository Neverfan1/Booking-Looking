//
//  UserModel.swift
//  Booking Looking
//
//  Created by Данила Парамин on 23.04.2023.
//

import Foundation
struct UserModel:Identifiable{
    let id: Int
    let email: String
    let name: String
    let surname: String
    let sex: Int
    let phoneNumber: String
    
    var fullName: String{
        name + " " + surname
    }
}
extension UserModel{
    static func mock() -> Self {
        UserModel(id: 1,
                  email: "test@gmail.com",
                  name: "Test",
                  surname: "Tester",
                  sex: 1,
                  phoneNumber: "+79999999999")
    }
}



