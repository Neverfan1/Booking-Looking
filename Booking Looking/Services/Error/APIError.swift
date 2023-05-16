//
//  APIError.swift
//  Booking Looking
//
//  Created by Данила Парамин on 20.04.2023.
//

import Foundation


enum APIError: Error {
    case serverError(message: String, errorCode: Int)
    
    var localizedDescription: String {
            switch self {
            case .serverError(let message, let errorCode):
                return "Server Error (code: \(errorCode)): \(message)"
            default:
                return "Unknown Error"
            }
        }
}
