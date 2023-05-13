//
//  BookingApiService.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 12.05.2023.
//

import Foundation
import Combine
import CombineMoya

struct BookingApiService {
    let provider = Provider<BookingApi>()
}

extension BookingApiService {
    func postDate(dates: [String:Any], id: Int) -> AnyPublisher<String, APIError> {
        provider.requestPublisher(.postDate(dates: dates, id: id))
            .filterSuccessfulStatusCodes()
            .map(ServerResponse<String>.self)
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
    
    func deleteDate(id: Int) -> AnyPublisher<String, APIError> {
        provider.requestPublisher(.deleteDate(id: id))
            .filterSuccessfulStatusCodes()
            .map(ServerResponse<String>.self)
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
