//
//  AccommodationCoordinator.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 15.05.2023.
//

import SwiftUI
import Stinsen

final class AccommodationCoordinator: NavigationCoordinatable {
    let stack = NavigationStack(initial: \AccommodationCoordinator.start)

    @Root var start = makeSearch
    @Route(.push) var detail = makeDetail
    @Route(.modal) var booking = makeBooking

    private let accomApiService = AccommodationApiService()
    private let bookingApiService = BookingApiService()
    
#if DEBUG
    deinit {
        print("Coordinator \(self) DEINITED!!!")
    }
#endif
}

extension AccommodationCoordinator {
    @ViewBuilder func makeSearch() -> some View {
        let viewModel = SearchAccommodationViewModel(apiService: accomApiService,
                                                     router: self)
        SearchAccommodation(viewModel: viewModel)
    }
    
    @ViewBuilder func makeDetail(id: Int) -> some View {
        let viewModel = AccommodationDetailViewModel(id: id,
                                                     apiService: accomApiService,
                                                     router: self)
        AccommodationDetail(viewModel: viewModel)
    }
    
    @ViewBuilder func makeBooking(args: ([DateModel], Int)) -> some View {
        let viewModel = BookingViewModel(id: args.1,
                                         freeDates: args.0,
                                         apiService: bookingApiService,
                                         router: self)
        BookingView(viewModel: viewModel)
    }
}
