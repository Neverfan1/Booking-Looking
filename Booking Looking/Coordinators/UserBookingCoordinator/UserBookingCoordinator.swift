//
//  UserBookingCoordinator.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 16.05.2023.
//

import SwiftUI
import Stinsen

final class UserBookingCoordinator: NavigationCoordinatable {

    let stack = NavigationStack(initial: \UserBookingCoordinator.booking)

    @Root var booking = makeUserBooking
    
    private let apiService = UserApiService()
    private let bookingApiService = BookingApiService()
    private let accomApiService = AccommodationApiService()
    
#if DEBUG
    deinit {
        print("Coordinator \(self) DEINITED!!!")
    }
#endif
}

extension UserBookingCoordinator {
    @ViewBuilder func makeUserBooking() -> some View {
        let viewModel = UserBookingViewModel(apiService: apiService,
                                             bookingApiService: bookingApiService)
        UserBooking(viewModel: viewModel)
    }
}
