//
//  UserApiService.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 10.05.2023.
//

import Foundation
import Combine
import CombineMoya

struct UserApiService {
    let provider = Provider<UserApi>()
}

extension UserApiService {
    func getDetailInfo(id: Int) -> AnyPublisher<UserModel, APIError> {
        provider.requestPublisher(.getDetail(id: id))
            .filterSuccessfulStatusCodes()
            .map(ServerResponse<ServerUser>.self)
            .map { $0.data }
            .map { UserModelMapper().toLocal(serverEntity: $0) }
            .mapError({ error in
                print(error)
                return .ParseError
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getBooking() -> AnyPublisher<[AccommodationModel], APIError> {
        provider.requestPublisher(.getBooking)
            .filterSuccessfulStatusCodes()
            .map(ServerResponse<[ServerUserBooking]>.self)
            .map { $0.data }
            .map { UserAccommodationModelMapper().toLocal(list: $0) }
            .mapError({ error in
                print(error)
                return .ParseError
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}