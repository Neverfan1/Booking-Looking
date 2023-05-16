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
             \TabBarCoordinator.groups,
             \TabBarCoordinator.userBookings,
             \TabBarCoordinator.accommodations
        ]
    )
    
    @Route(tabItem: makeGroupsTab) var groups = makeGroups
    @Route(tabItem: makeUserBookingsTab) var userBookings = makeUserBookings
    @Route(tabItem: makeAccommodationsTab) var accommodations = makeAccommodations
    
    #if DEBUG
    deinit {
        print("Deinit AuthenticatedCoordinator")
    }
    #endif
}

extension TabBarCoordinator {
    func makeGroups() -> NavigationViewCoordinator<UserCoordinator> {
        NavigationViewCoordinator(UserCoordinator())
    }
    
    @ViewBuilder func makeGroupsTab(isActive: Bool) -> some View {
        Image(systemName: "person.3")
        Text("Профиль")
    }
    
    func makeAccommodations() -> NavigationViewCoordinator<AccommodationCoordinator> {
        NavigationViewCoordinator(AccommodationCoordinator())
    }

    func makeUserBookings() -> NavigationViewCoordinator<UserBookingCoordinator> {
        NavigationViewCoordinator(UserBookingCoordinator())
    }

    @ViewBuilder func makeUserBookingsTab(isActive: Bool) -> some View {
        Image(systemName: "dollarsign.arrow.circlepath")
        Text("Брони")
    }
    
    @ViewBuilder func makeAccommodationsTab(isActive: Bool) -> some View {
        Image(systemName: "house")
        Text("Жилища")
    }
}



