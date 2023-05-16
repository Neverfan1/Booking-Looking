//
//  OwnerModelMapper.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 17.05.2023.
//

import Foundation

final class OwnerModelMapper: BaseModelMapper<ServerOwnerModel, OwnerModel> {
    override func toLocal(serverEntity: ServerOwnerModel) -> OwnerModel {
        OwnerModel(id: serverEntity.id,
                   name: serverEntity.name.orEmpty,
                   contact: serverEntity.contact.orEmpty,
                   description: serverEntity.description.orEmpty,
                   image: serverEntity.image.orEmpty)
    }
}
