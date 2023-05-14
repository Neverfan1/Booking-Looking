//
//  MainCoordinator.swift
//  Booking Looking
//
//  Created by Данила Парамин on 20.04.2023.
//

import Foundation
import SwiftUI
import Stinsen
import Combine

final class MainCoordinator: NavigationCoordinatable {

    var stack = Stinsen.NavigationStack<MainCoordinator>(initial: \.authorization)

    @Root var authorization = makeAuthorization
    @Root var general = makeTabBar
    
    let authState = CurrentValueSubject<AuthState, Never>(.unauthorized)
    private var cancellable = Set<AnyCancellable>()

    init() {
        if LocalStorage.current.token.isEmpty {
            stack = NavigationStack(initial: \MainCoordinator.authorization)
        } else {
            stack = NavigationStack(initial: \MainCoordinator.general)
        }
        
        authState
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }

                switch state {
                case .unauthorized:
                    self.root(\.authorization)
                case .authorized:
                    self.root(\.general)
                }
            }
            .store(in: &cancellable)
    }
}

extension MainCoordinator {
    func makeAuthorization() -> NavigationViewCoordinator<AuthorizationCoordinator> {
        let coordinator = AuthorizationCoordinator(authState: authState)
        let stack = NavigationViewCoordinator(coordinator)
        return stack
    }

    func makeTabBar() -> TabBarCoordinator {
        TabBarCoordinator()
    }
}
