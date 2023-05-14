//
//  AuthorizationCoordinator.swift
//  Booking Looking
//
//  Created by Данила Парамин on 02.05.2023.
//

import Foundation
import SwiftUI
import Stinsen
import Combine

final class AuthorizationCoordinator: NavigationCoordinatable {
    
    let stack = NavigationStack(initial: \AuthorizationCoordinator.login)
    
    @Root var login = makeLogin
    @Route(.modal) var register = makeRegistration
    @Route(.push) var code = makeCode
    
    let authState: CurrentValueSubject<AuthState, Never>
    private let apiService = AuthApiService()
    
    init(authState: CurrentValueSubject<AuthState, Never>) {
        self.authState = authState
    }
    
#if DEBUG
    deinit {
        print("Coordinator \(self) DEINITED!!!")
    }
#endif
}

extension AuthorizationCoordinator {
    
    @ViewBuilder func makeLogin() -> some View {
        let viewModel = AuthorizationViewModel(apiService: apiService,
                                               router: self)
        LoginView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeRegistration() -> some View {
        let viewModel = RegistrationViewModel(apiService: apiService,
                                              router: self)
        RegistrationView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeCode() -> some View {
        let viewModel = EnterCodeViewModel(apiService: apiService,
                                           router: self)
        EnterCodeScreen2(viewModel: viewModel)
    }
}
