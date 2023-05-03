//
//  UserCoordinator.swift
//  Booking Looking
//
//  Created by Данила Парамин on 02.05.2023.
//

import Foundation
import SwiftUI
import Stinsen

final class UserCoordinator: NavigationCoordinatable {

    let stack = NavigationStack(initial: \UserCoordinator.start)

    @Root var start = makeUser


#if DEBUG
    deinit {
        print("Coordinator \(self) DEINITED!!!")
    }
#endif
}

extension UserCoordinator {
    
    @ViewBuilder func makeUser(model: UserModel) -> some View {
//        let viewModel = GroupListViewModel(router: self, api: VKAPIService())
        UserView(user: model)
    }
    

}
