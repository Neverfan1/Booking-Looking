//
//  BookingApiService.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 12.05.2023.
//

import Foundation
import Combine
import CombineMoya

// MARK: - Protocols
protocol BookingPostApiProtocol {
    func postDate(dates: [[String:Any]], id: Int) -> AnyPublisher<String, APIError>
}

protocol BookingDeleteApiProtocol {
    func deleteDate(id: Int) -> AnyPublisher<String, APIError>
}

struct BookingApiService {
    let provider = Provider<BookingApi>()
}

// MARK: - API-methods
extension BookingApiService: BookingPostApiProtocol {
    func postDate(dates: [[String:Any]], id: Int) -> AnyPublisher<String, APIError> {
        provider.requestPublisher(.postDate(dates: dates, id: id))
            .filterSuccessfulStatusCodes()
            .mapToValue("Жилье забронировано")
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

extension BookingApiService: BookingDeleteApiProtocol {
    func deleteDate(id: Int) -> AnyPublisher<String, APIError> {
        provider.requestPublisher(.deleteDate(id: id))
            .filterSuccessfulStatusCodes()
            .mapToValue("Бронь отменена")
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
