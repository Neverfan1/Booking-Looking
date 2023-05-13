//
//  AuthApiService.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 10.05.2023.
//

import Foundation
import Moya
import Combine
import CombineMoya

struct AuthApiService {
    let provider = Provider<AuthApi>()
}

extension AuthApiService {
    func authorize(email: String) -> AnyPublisher<AuthResponse, APIError> {
        provider.requestPublisher(.authorization(email: email))
            .filterSuccessfulStatusCodes()
            .map(ServerResponse<ServerAuthResponse>.self)
            .map { $0.data }
            .map { AuthModelMapper().toLocal(serverEntity: $0) }
            .mapError({ error in
                print(error)
                return .ParseError
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func checkCode(user: Int, code: String) -> AnyPublisher<CheckCode, APIError> {
        provider.requestPublisher(.checkCode(user: user,
                                             code: code))
            .filterSuccessfulStatusCodes()
            .map(ServerResponse<ServerCheckCode>.self)
            .map { $0.data }
            .map { CheckCodeModelMapper().toLocal(serverEntity: $0) }
            .mapError { error in
                print(error)
                return .ParseError
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func registration(phone: String,
                      surname: String,
                      name: String,
                      sex: Int,
                      email: String) -> AnyPublisher<AuthResponse, APIError> {
        provider.requestPublisher(.registration(phone: phone,
                                                surname: surname,
                                                name: name,
                                                sex: sex,
                                                email: email))
            .filterSuccessfulStatusCodes()
            .map(ServerResponse<ServerAuthResponse>.self)
            .map { $0.data }
            .map { AuthModelMapper().toLocal(serverEntity: $0) }
            .mapError { error in
                print(error)
                return .ParseError
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
