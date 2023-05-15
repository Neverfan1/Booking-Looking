//
//  OwnerModel.swift
//  Booking Looking
//
//  Created by Данила Парамин on 15.05.2023.
//

import Foundation

struct OwnerModel:Identifiable{
    let id: Int
    let name: String
    let contact: String
    let description: String
    let image: String
    
}
extension OwnerModel{
    static func mock() -> Self {
        OwnerModel(id: 1, name: "Owner", contact: "89999999999", description: "Тестовый овнер 1 арвырдаы дфрадвоп фоа фло арфвда дфпвда паорпф а флвраолфрвлоа флвоалфрвларфрылвфова", image: "https://img.freepik.com/free-photo/close-up-portrait-of-a-young-bearded-man-face_171337-2887.jpg")
    }
}
