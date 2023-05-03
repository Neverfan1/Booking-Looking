//
//  Validation.swift
//  Booking Looking
//
//  Created by Данила Парамин on 28.04.2023.
//

import Foundation

func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
    let pattern = "^8\\d{10}$"
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    return regex?.firstMatch(in: phoneNumber, options: [], range: NSRange(location: 0, length: phoneNumber.count)) != nil
}


func isValidEmail(_ email: String) -> Bool {
    let pattern = "^[^@]+@[^@]+\\.(ru|com)$"
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    return regex?.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil
}


