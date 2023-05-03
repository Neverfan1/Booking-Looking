//
//  AuthorizationCoordinator.swift
//  Booking Looking
//
//  Created by Данила Парамин on 02.05.2023.
//

import Foundation
import SwiftUI
import Stinsen

final class AuthorizationCoordinator: NavigationCoordinatable {
    
    let stack = NavigationStack(initial: \AuthorizationCoordinator.loginBL)
    
    @Root var loginBL = makeLogin
    @Route(.modal) var webLogin = makeRegistration
    
#if DEBUG
    deinit {
        print("Coordinator \(self) DEINITED!!!")
    }
#endif
}

extension AuthorizationCoordinator {
    
    @ViewBuilder func makeLogin() -> some View {
//        let viewModel = (router: self)
        LoginView()
    }
    
    @ViewBuilder func makeRegistration() -> some View {
//        let viewModel = WebViewRepresentableModel()
        RegistrationView()
    }
}
