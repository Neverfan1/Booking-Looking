//
//  ServerResponse.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 10.05.2023.
//

import Foundation

struct ServerResponse<T: Codable>: Codable {
    let data: T
    let message: String
}
