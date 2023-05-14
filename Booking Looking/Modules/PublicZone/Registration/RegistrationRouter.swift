//
//  RegistrationRouter.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 14.05.2023.
//

import Foundation

protocol RegistrationRouter: AnyObject {
    func pushToCode()
}

extension AuthorizationCoordinator: RegistrationRouter {
    func pushToCode() {
        self.route(to: \.code)
    }
}
