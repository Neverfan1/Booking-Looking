//
//  OwnerProfileRouter.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 17.05.2023.
//

import Foundation

protocol OwnerProfileRouter: AnyObject {
    func pushToDetail(id: Int)
    func back()
}

extension AccommodationCoordinator: OwnerProfileRouter {
    func pushToDetail(id: Int) {
        self.route(to: \.detail, id)
    }
    
    func back() {
        self.popLast(nil)
    }
}
