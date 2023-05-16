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
            .mapError({ error in
                #if DEBUG
                print(error)
                #endif
                return .DateError
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension BookingApiService: BookingDeleteApiProtocol {
    func deleteDate(id: Int) -> AnyPublisher<String, APIError> {
        provider.requestPublisher(.deleteDate(id: id))
            .filterSuccessfulStatusCodes()
            .mapToValue("Бронь отменена")
            .mapError({ error in
                #if DEBUG
                print(error)
                #endif
                return .DateError
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
