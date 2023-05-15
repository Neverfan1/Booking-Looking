//
//  CheckCodeModelMapper.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 10.05.2023.
//

import Foundation

final class CheckCodeModelMapper: BaseModelMapper<ServerCheckCode, CheckCode> {
    override func toLocal(serverEntity: ServerCheckCode) -> CheckCode {
        CheckCode(token: serverEntity.token.orEmpty,
                  userId: serverEntity.userId ?? -1)
    }
}
