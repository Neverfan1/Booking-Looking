//
//  UserCoordinator.swift
//  Booking Looking
//
//  Created by Данила Парамин on 02.05.2023.
//

import Foundation
import SwiftUI
import Stinsen
import Combine

final class UserCoordinator: NavigationCoordinatable {

    let stack = NavigationStack(initial: \UserCoordinator.start)

    @Root var start = makeUser
    
    private let apiService = UserApiService()
    private var authState: CurrentValueSubject<AuthState, Never>
    
    init(authState: CurrentValueSubject<AuthState, Never>) {
        self.authState = authState
    }
    
    #if DEBUG
    deinit {
        print("Coordinator \(self) DEINITED!!!")
    }
    #endif
}

extension UserCoordinator {
    @ViewBuilder func makeUser() -> some View {
        let viewModel = UserProfileViewModel(apiService: apiService, authState: authState)
        UserView(viewModel: viewModel)
    }
}
