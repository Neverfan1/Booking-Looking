//
//  TabBarCoordinator.swift
//  Booking Looking
//
//  Created by Данила Парамин on 02.05.2023.
//

import Foundation
import SwiftUI
import Stinsen
import Combine

final class TabBarCoordinator: TabCoordinatable {
    var child = TabChild(
        startingItems: [
            \TabBarCoordinator.groups
//             \TabBarCoordinator.photos,
//             \TabBarCoordinator.friends,
//             \TabBarCoordinator.exit,
             
        ]
    )
    
    @Route(tabItem: makeGroupsTab) var groups = makeGroups
//    @Route(tabItem: makePhotosTab) var photos = makePhotos
//    @Route(tabItem: makeFriendsTab) var friends = makeFriends
//    @Route(tabItem: makeExitTab) var exit = makeExit
    
    deinit {
        print("Deinit AuthenticatedCoordinator")
    }
}

extension TabBarCoordinator {
    
    func makeGroups() -> NavigationViewCoordinator<UserCoordinator> {
        NavigationViewCoordinator(UserCoordinator())
    }
    
    @ViewBuilder func makeGroupsTab(isActive: Bool) -> some View {
        Image(systemName: "person.3")
        Text("Profile")
    }
    


    
    
}



