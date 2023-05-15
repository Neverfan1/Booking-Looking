//
//  BookingRouter.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 15.05.2023.
//

import Foundation

protocol BookingRouter: AnyObject {
    func pop()
}

extension AccommodationCoordinator: BookingRouter {
    func pop() {
        self.popLast(nil)
    }
}
