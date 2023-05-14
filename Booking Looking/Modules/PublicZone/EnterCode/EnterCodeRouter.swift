//
//  EnterCodeRouter.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 14.05.2023.
//

import Foundation

protocol EnterCodeRouter: AnyObject {
    func close()
}

extension AuthorizationCoordinator: EnterCodeRouter {
    func close() {
        self.authState.send(.authorized)
    }
}
