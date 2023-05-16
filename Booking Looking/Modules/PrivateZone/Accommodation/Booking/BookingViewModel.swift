//
//  BookingViewModel.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 15.05.2023.
//

import Foundation
import Combine
import CombineExt

final class BookingViewModel: ObservableObject {
    // MARK: - Services
    weak var router: BookingRouter?
    private let apiService: BookingPostApiProtocol
    private let onUpdate: PassthroughSubject<Void, Never>
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(id: Int,
         freeDates: [DateModel],
         apiService: BookingPostApiProtocol,
         onUpdate: PassthroughSubject<Void, Never>,
         router: BookingRouter?) {
        self.apiService = apiService
        self.onUpdate = onUpdate
        self.router = router
        
        self.input = Input()
        self.output = Output(freeDates: freeDates,
                             id: id)
        
        bind()
    }
}

private extension BookingViewModel {
    func bind() {
        bindOnSaveTap()
    }
    
    func bindOnSaveTap() {
        let request = input.onSave
            .handleEvents(receiveOutput: { [weak self] in
                self?.output.screenState = .loading
            })
            .map { [unowned self] in
                // TODO: - do huetu
                self.apiService.postDate(dates: groupDatesByMonthAndYear(self.output.selectedDates),
                                         id: self.output.id)
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
            .mapToVoid()
            .handleEvents(receiveOutput: { [weak self] in
                self?.onUpdate.send()
            })
            .sink { [weak self] in
                self?.router?.pop()
            }
            .store(in: &cancellable)
    }
}

extension BookingViewModel {
    struct Input {
        let onSave = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var screenState: ProcessingState = .loaded
        var freeDates: [DateModel]
        var id: Int
        var selectedDates: [Date] = []
    }
}
