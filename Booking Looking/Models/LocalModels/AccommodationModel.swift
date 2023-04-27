//
//  AccommodationModel.swift
//  Booking Looking
//
//  Created by Данила Парамин on 23.04.2023.
//

import Foundation

struct AccommodationModel:Identifiable{
    
    let id: Int
    let owner_id: Int
    let owner_name: String
    let image_preview: String
    let price: Int

}
extension AccommodationModel{
    static func mock() -> Self {
        AccommodationModel(id: 1,
                           owner_id: 1,
                           owner_name: "test",
                           image_preview: "https://drive.google.com/file/d/1iX6zeIqie2T4CRQYhLHw7r62m7rm6U8C/view?usp=share_link",
                           price: 4000)
    }
}
