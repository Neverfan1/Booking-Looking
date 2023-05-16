//
//  ServerBooking.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 12.05.2023.
//

import Foundation

struct ServerUserBooking: Codable {
    let accommodationID: Int
    let bookingID: Int?
    let type: String?
    let ownerID: Int?
    let ownerName: String?
    let imagePreview: String?
    let images: [String]?
    let price: Int?
    let bookingDates: [ServerDate]?
    let address: String?
    
    enum CodingKeys: String, CodingKey {
        case bookingID = "booking_id"
        case accommodationID = "accommodation_id"
        case type
        case ownerID = "owner_id"
        case ownerName = "owner_name"
        case imagePreview = "image_preview"
        case images, price
        case bookingDates = "booking_dates"
        case address
    }
}

struct ServerDate: Codable {
    let month: String?
    let year: Int?
    let date: [Int]?
}

struct ServerSearchBooking: Codable {
    let id: Int
    let type: String?
    let ownerId: Int?
    let ownerName: String?
    let imagePreview: String?
    let address: String?
    let price: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "accommodation_id"
        case type
        case ownerId = "owner_id"
        case ownerName = "owner_name"
        case imagePreview = "image_preview"
        case address
        case price
    }
}

struct ServerDetailBooking: Codable {
    let id: Int
    let address: String?
    let description: String?
    let imagePreview: String?
    let images: [String]?
    let type: String?
    let rooms: Int?
    let beds: Int?
    let capacity: Int?
    let ownerId: Int?
    let ownerName: String?
    let price: Int?
    let cancellationPolicy: String?
    let freeDates: [ServerDate]?
    
    enum CodingKeys: String, CodingKey {
        case id = "accommodation_id"
        case address
        case description
        case imagePreview = "image_preview"
        case images
        case type
        case rooms
        case beds
        case capacity
        case ownerId = "owner_id"
        case ownerName = "owner_name"
        case price
        case cancellationPolicy
        case freeDates = "free_dates"
    }
}
