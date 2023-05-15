//
//  CheckCodeResponse.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 10.05.2023.
//

import Foundation

struct ServerCheckCode: Codable {
    let token: String?
    let userId: Int?
    
    enum CodingKeys: String, CodingKey {
        case token
        case userId = "user id"
    }
}

struct CheckCode {
    let token: String
    let userId: Int
}
