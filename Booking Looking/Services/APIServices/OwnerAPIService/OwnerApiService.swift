//
//  OwnerApiService.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 17.05.2023.
//

import Foundation
import Combine
import Moya
import CombineMoya

protocol OwnerDetailApiProtocol {
    func getOwnerDetail(id: Int) -> AnyPublisher<OwnerModel, APIError>
}

protocol OwnerAccomApiProtocol {
    func getOwnerAccommodations(id: Int) -> AnyPublisher<[AccommodationSearchModel], APIError>
}

protocol CommonOwnerApiProtocol: OwnerAccomApiProtocol, OwnerDetailApiProtocol { }

struct OwnerApiService {
    let provider = Provider<OwnerApi>()
}

extension OwnerApiService: OwnerDetailApiProtocol {
    func getOwnerDetail(id: Int) -> AnyPublisher<OwnerModel, APIError> {
        provider.requestPublisher(.ownerDetail(id: id))
            .filterSuccessfulStatusCodes()
            .map(ServerResponse<ServerOwnerModel>.self)
            .map { $0.data }
            .map { OwnerModelMapper().toLocal(serverEntity: $0) }
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

extension OwnerApiService: OwnerAccomApiProtocol {
    func getOwnerAccommodations(id: Int) -> AnyPublisher<[AccommodationSearchModel], APIError> {
        provider.requestPublisher(.ownerAccommodation(id: id))
            .filterSuccessfulStatusCodes()
            .map(ServerResponse<[ServerSearchBooking]>.self)
            .map { $0.data }
            .map { AccommodationSearchMapper().toLocal(list: $0) }
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

extension OwnerApiService: CommonOwnerApiProtocol { }
