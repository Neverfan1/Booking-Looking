//
//  AuthorizationRouter.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 14.05.2023.
//

import Foundation

protocol AuthorizationRouter: AnyObject {
    func pushToCode()
    func pushToRegister()
}

extension AuthorizationCoordinator: AuthorizationRouter {
    func pushToRegister() {
        self.route(to: \.register)
    }
}
