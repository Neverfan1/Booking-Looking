//
//  ServerUserModel.swift
//  Booking Looking
//
//  Created by Данила Парамин on 23.04.2023.
//

import Foundation

// MARK: - User
struct UserData: Codable {
    let data: User?
    let message: String?
}

// MARK: - DataClass
struct User: Codable {
    let email, name, surname: String?
    let sex: Int?
    let phoneNumber: String?

    enum CodingKeys: String, CodingKey {
        case email, name, surname, sex
        case phoneNumber = "phone_number"
    }
}
