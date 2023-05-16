//
//  AccommodationDetailRouter.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 15.05.2023.
//

import Foundation

protocol AccommodationDetailRouter: AnyObject {
    func modalToBooking(args: ([DateModel], Int))
    func pushToOwner(id: (Int, Int))
}

extension AccommodationCoordinator: AccommodationDetailRouter {
    func pushToOwner(id: (Int, Int)) {
        self.route(to: \.ownerProfile, id)
    }
    
    func modalToBooking(args: ([DateModel], Int)) {
        self.route(to: \.booking, args)
    }
}
