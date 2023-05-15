//
//  UserBookingViewModel.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 14.05.2023.
//

import Foundation
import Combine
import CombineExt

final class UserBookingViewModel: ObservableObject {
    // MARK: - Services
    private let apiService: ProfileBookingApiProtocol
    private let bookingApiService: BookingDeleteApiProtocol
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(apiService: ProfileBookingApiProtocol,
         bookingApiService: BookingDeleteApiProtocol) {
        self.apiService = apiService
        self.bookingApiService = bookingApiService
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
}

private extension UserBookingViewModel {
    func bind() {
        bindOnAppear()
        bindOnDelete()
        bindOnDetail()
    }
    
    func bindOnAppear() {
        let request = input.onAppear
            .handleEvents(receiveOutput: { [weak self] in
                self?.output.screenState = .loading
            })
            .map { [unowned self] in
                self.apiService.getBooking()
                    .materialize()
            }
            .switchToLatest()
            .share()
        
        request
            .failures()
            .sink { [weak self] error in
                print(error)
                self?.output.screenState = .error(message: error.localizedDescription)
            }
            .store(in: &cancellable)
        
        request
            .values()
            .sink { [weak self] in
                self?.output.accommodations = $0
                self?.output.screenState = .loaded
            }
            .store(in: &cancellable)
    }
    
    func bindOnDelete() {
        let request = input.onDeleteTap
            .map { [unowned self] in
                self.bookingApiService.deleteDate(id: $0)
                    .materialize()
            }
            .switchToLatest()
            .share()
        
        request
            .failures()
            .sink { [weak self] error in
                self?.output.screenState = .error(message: error.localizedDescription)
            }
            .store(in: &cancellable)
        
        request
            .values()
            .sink { [weak self] in
                self?.output.alertMessage = $0
                self?.output.isShowingAlert = true
            }
            .store(in: &cancellable)
    }
    
    func bindOnDetail() {
        
    }
}

extension UserBookingViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let onDeleteTap = PassthroughSubject<Int, Never>()
        let onDetailTap = PassthroughSubject<Int, Never>()
    }
    
    struct Output {
        var screenState: ProcessingState = .loading
        var accommodations: [AccommodationModel] = []
        
        var isShowingAlert = false
        var alertMessage = ""
    }
}
