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
    @Route(.push) var booking = makeUserBooking
    
    private let apiService = UserApiService()
    private let bookingApiService = BookingApiService()
    private let accomApiService = AccommodationApiService()
    
#if DEBUG
    deinit {
        print("Coordinator \(self) DEINITED!!!")
    }
#endif
}

extension UserCoordinator {
    @ViewBuilder func makeUser() -> some View {
        let viewModel = UserProfileViewModel(apiService: apiService)
        UserView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeUserBooking() -> some View {
        let viewModel = UserBookingViewModel(apiService: apiService,
                                             bookingApiService: bookingApiService)
    }
}
