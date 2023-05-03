//
//  MainCoordinator.swift
//  Booking Looking
//
//  Created by Данила Парамин on 20.04.2023.
//

import Foundation
import SwiftUI
import Stinsen

final class MainCoordinator: NavigationCoordinatable {

    var stack = Stinsen.NavigationStack<MainCoordinator>(initial: \.authorization)

    @Root var authorization = makeAuthorization
    @Root var general = makeTabBar

    init() {
        if AuthenticationLocalService.shared.status.value {
            stack = NavigationStack(initial: \MainCoordinator.general)
        } else {
            stack = NavigationStack(initial: \MainCoordinator.authorization)
        }
    }

    @ViewBuilder func customize(_ view: AnyView) -> some View {
        view
            .onReceive(AuthenticationLocalService.shared.status) { status in
                if status {
                    self.root(\.general)
                } else {
                    self.root(\.authorization)
                }
            }
    }
}

extension MainCoordinator {


    func makeAuthorization() -> NavigationViewCoordinator<AuthorizationCoordinator> {
        let coordinator = AuthorizationCoordinator()
        let stack = NavigationViewCoordinator(coordinator)
        return stack
    }

    func makeTabBar() -> TabBarCoordinator {
        TabBarCoordinator()
    }
}
