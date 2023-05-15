//
//  AuthResponse.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 10.05.2023.
//

import Foundation

struct ServerAuthResponse: Codable {
    let userId: Int?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user id"
    }
}

struct AuthResponse {
    let userId: Int
}
