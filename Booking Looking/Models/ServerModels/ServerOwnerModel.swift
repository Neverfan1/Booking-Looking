//
//  OwnerModel.swift
//  Booking Looking
//
//  Created by Данила Парамин on 15.05.2023.
//
import Foundation

struct ServerOwnerModel: Codable {
    let id: Int
    let name: String?
    let contact: String?
    let description: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "owner_id"
        case name
        case contact
        case description
        case image
    }
}
