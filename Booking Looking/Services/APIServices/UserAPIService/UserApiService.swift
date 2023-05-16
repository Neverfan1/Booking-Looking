//
//  UserApiService.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 10.05.2023.
//

import Foundation
import Combine
import CombineMoya

// MARK: - Protocols
protocol ProfileApiProtocol {
    func getDetailInfo() -> AnyPublisher<UserModel, APIError>
}

protocol ProfileBookingApiProtocol {
    func getBooking() -> AnyPublisher<[AccommodationModel], APIError>
}

struct UserApiService {
    let provider = Provider<UserApi>()
}

// MARK: - API-methods
extension UserApiService: ProfileApiProtocol {
    func getDetailInfo() -> AnyPublisher<UserModel, APIError> {
        provider.requestPublisher(.getDetail)
            .filterSuccessfulStatusCodes()
            .map(ServerResponse<ServerUser>.self)
            .map { $0.data }
            .map { UserModelMapper().toLocal(serverEntity: $0) }
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

extension UserApiService: ProfileBookingApiProtocol {
    func getBooking() -> AnyPublisher<[AccommodationModel], APIError> {
        provider.requestPublisher(.getBooking)
            .filterSuccessfulStatusCodes()
            .map(ServerResponse<[ServerUserBooking]>.self)
            .map { $0.data }
            .map { UserAccommodationModelMapper().toLocal(list: $0) }
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
