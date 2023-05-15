//
//  UserModel.swift
//  Booking Looking
//
//  Created by Данила Парамин on 23.04.2023.
//

import Foundation

struct UserModel: Identifiable{
    let id: Int
    let email: String
    let name: String
    let surname: String
    let sex: Int
    let phoneNumber: String
    
    init(email: String, name: String, surname: String, sex: Int, phoneNumber: String) {
        self.id = UUID().hashValue
        self.email = email
        self.name = name
        self.surname = surname
        self.sex = sex
        self.phoneNumber = phoneNumber
    }
    
    var fullName: String{
        name + " " + surname
    }
}
extension UserModel{
    static func mock() -> Self {
        UserModel(email: "test@gmail.com",
                  name: "Test",
                  surname: "Tester",
                  sex: 1,
                  phoneNumber: "+79999999999")
    }
}



