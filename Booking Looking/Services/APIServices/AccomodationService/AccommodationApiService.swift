//
//  AccommodationApiService.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 12.05.2023.
//

import Foundation
import Combine
import Moya
import CombineMoya

// MARK: - Protocols
protocol ADetailApiProtocol {
    func getDetail(id: Int) -> AnyPublisher<AccommodationDetailModel, APIError>
}

protocol AFilterApiProtocol {
    func getFilter(type: String?, rooms: Int?, beds: Int?, capacity: Int?, priceTo: Int?, priceFrom: Int?, offset: Int, count: Int) -> AnyPublisher<[AccommodationSearchModel], APIError>
}

struct AccommodationApiService {
    let provider = Provider<AccommodationApi>()
}

// MARK: - API-methods
extension AccommodationApiService: ADetailApiProtocol {
    func getDetail(id: Int) -> AnyPublisher<AccommodationDetailModel, APIError> {
        provider.requestPublisher(.detail(id: id))
            .filterSuccessfulStatusCodes()
            .map(ServerResponse<ServerDetailBooking>.self)
            .map { $0.data }
            .map {
                AccommodationDetailMapper().toLocal(serverEntity: $0)
            }
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

extension AccommodationApiService: AFilterApiProtocol {
    func getFilter(type: String?, rooms: Int?, beds: Int?, capacity: Int?, priceTo: Int?, priceFrom: Int?, offset: Int, count: Int) -> AnyPublisher<[AccommodationSearchModel], APIError> {
        provider.requestPublisher(.filter(type: type, rooms: rooms, beds: beds, capacity: capacity, priceTo: priceTo, priceFrom: priceFrom, offset: offset, count: count))
            .filterSuccessfulStatusCodes()
            .map(ServerResponse<[ServerSearchBooking]>.self)
            .map { $0.data }
            .map {
                AccommodationSearchMapper().toLocal(list: $0)
            }
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
