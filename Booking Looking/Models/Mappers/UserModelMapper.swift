//
//  UserModelMapper.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 10.05.2023.
//

import Foundation

final class UserModelMapper: BaseModelMapper<ServerUser, UserModel> {
    override func toLocal(serverEntity: ServerUser) -> UserModel {
        UserModel(email: serverEntity.email.orEmpty,
                  name: serverEntity.name.orEmpty,
                  surname: serverEntity.surname.orEmpty,
                  sex: serverEntity.sex ?? -1,
                  phoneNumber: serverEntity.phoneNumber.orEmpty)
    }
}
