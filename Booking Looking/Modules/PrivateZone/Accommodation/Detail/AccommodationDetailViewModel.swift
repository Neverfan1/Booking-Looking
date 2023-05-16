//
//  AccommodationDetailViewModel.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 14.05.2023.
//

import Foundation
import Combine
import CombineExt

final class AccommodationDetailViewModel: ObservableObject {
    // MARK: - Services
    weak var router: AccommodationDetailRouter?
    private let apiService: ADetailApiProtocol
    private let onUpdate: PassthroughSubject<Void, Never>
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - External
    private let id: Int
    
    init(id: Int,
         apiService: ADetailApiProtocol,
         onUpdate: PassthroughSubject<Void, Never>,
         router: AccommodationDetailRouter?) {
        self.id = id
        self.apiService = apiService
        self.onUpdate = onUpdate
        self.router = router
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
}

private extension AccommodationDetailViewModel {
    func bind() {
        bindOnAppear()
        bindOnDateTap()
        bindOwnerTap()
        bindOnUpdate()
    }
    
    func bindOnAppear() {
        let request = input.onAppear
            .handleEvents(receiveOutput: { [weak self] in
                self?.output.screenState = .loading
            })
            .map { [unowned self] in
                self.apiService.getDetail(id: self.id)
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
                self?.output.accommodation = $0
                self?.output.screenState = .loaded
            }
            .store(in: &cancellable)
    }
    
    func bindOnUpdate() {
        onUpdate
            .sink { [weak self] in
                self?.input.onAppear.send()
            }
            .store(in: &cancellable)
    }
    
    func bindOnDateTap() {
        input.onDateTap
            .sink { [weak self] in
                guard let self = self else { return }
                self.router?.modalToBooking(args: (self.output.accommodation.freeDates,
                                                   self.output.accommodation.id))
            }
            .store(in: &cancellable)
    }
    
    func bindOwnerTap() {
        input.onOwnerTap
            .sink { [weak self] id in
                guard let self = self else { return }
                self.router?.pushToOwner(id: (id, self.output.accommodation.id))
            }
            .store(in: &cancellable)
    }
}

extension AccommodationDetailViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let onDateTap = PassthroughSubject<Void, Never>()
        let onOwnerTap = PassthroughSubject<Int, Never>()
    }
    
    struct Output {
        var screenState: ProcessingState = .loading
        var accommodation: AccommodationDetailModel = .mock()
    }
}
