//
//  SearchAccommodationRouter.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 15.05.2023.
//

import Foundation

protocol SearchAccommodationRouter: AnyObject {
    func pushToDetails(id: Int)
}

extension AccommodationCoordinator: SearchAccommodationRouter {
    func pushToDetails(id: Int) {
        self.route(to: \.detail, id)
    }
}
