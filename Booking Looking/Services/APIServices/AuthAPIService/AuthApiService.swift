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


// MARK: - Protocols
protocol RegistraionApiProtocol {
    func registration(phone: String,
                      surname: String,
                      name: String,
                      sex: Int,
                      email: String) -> AnyPublisher<AuthResponse, APIError>
}

protocol AuthorizationApiProtocol {
    func authorize(email: String) -> AnyPublisher<AuthResponse, APIError>
}

protocol CodeApiProtocol {
    func checkCode(user: Int, code: String) -> AnyPublisher<CheckCode, APIError>
}

// MARK: - Service
struct AuthApiService {
    let provider = Provider<AuthApi>()
}

// MARK: - API-methods
extension AuthApiService: AuthorizationApiProtocol {
    func authorize(email: String) -> AnyPublisher<AuthResponse, APIError> {
        provider.requestPublisher(.authorization(email: email))
            .filterSuccessfulStatusCodes()
            .map(ServerResponse<ServerAuthResponse>.self)
            .map { $0.data }
            .map { AuthModelMapper().toLocal(serverEntity: $0) }
            .mapError { error -> APIError in
                if let responseData = error.response?.data {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: responseData)
                        return .serverError(message: errorResponse.message, errorCode: errorResponse.errorCode)
                    } catch {
                        print("Decoding error: \(error)")
                    }
                }
                print("Other error: \(error)")
                return .serverError(message: "Неизвестная ошибка", errorCode: -1)
            }

            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension AuthApiService: CodeApiProtocol {
    func checkCode(user: Int, code: String) -> AnyPublisher<CheckCode, APIError> {
        provider.requestPublisher(.checkCode(user: user,
                                             code: code))
            .filterSuccessfulStatusCodes()
            .map(ServerResponse<ServerCheckCode>.self)
            .map { $0.data }
            .map { CheckCodeModelMapper().toLocal(serverEntity: $0) }
            .mapError { error -> APIError in
                if let responseData = error.response?.data {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: responseData)
                        return .serverError(message: errorResponse.message, errorCode: errorResponse.errorCode)
                    } catch {
                        print("Decoding error: \(error)")
                    }
                }
                print("Other error: \(error)")
                return .serverError(message: "Неизвестная ошибка", errorCode: -1)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension AuthApiService: RegistraionApiProtocol {
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
            .mapError { error -> APIError in
                if let responseData = error.response?.data {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: responseData)
                        return .serverError(message: errorResponse.message, errorCode: errorResponse.errorCode)
                    } catch {
                        print("Decoding error: \(error)")
                    }
                }
                print("Other error: \(error)")
                return .serverError(message: "Неизвестная ошибка", errorCode: -1)
            }

            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

