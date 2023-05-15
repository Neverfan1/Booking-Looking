//
//  AccommodationDetailRouter.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 15.05.2023.
//

import Foundation

protocol AccommodationDetailRouter: AnyObject {
    func modalToBooking(args: ([DateModel], Int))
}

extension AccommodationCoordinator: AccommodationDetailRouter {
    func modalToBooking(args: ([DateModel], Int)) {
        self.route(to: \.booking, args)
    }
}
