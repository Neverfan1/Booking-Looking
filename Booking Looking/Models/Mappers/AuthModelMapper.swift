//
//  AuthModelMapper.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 10.05.2023.
//

import Foundation

final class AuthModelMapper: BaseModelMapper<ServerAuthResponse, AuthResponse> {
    override func toLocal(serverEntity: ServerAuthResponse) -> AuthResponse {
        AuthResponse(userId: serverEntity.userId ?? -1)
    }
}
