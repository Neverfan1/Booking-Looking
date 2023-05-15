//
//  SearchAccommodationViewModel.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 15.05.2023.
//

import Foundation
import Combine
import CombineExt

final class SearchAccommodationViewModel: ObservableObject {
    // MARK: - Services
    private let apiService: AFilterApiProtocol
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Internal
    private var offset = 0
    private var count = 10
    
    init(apiService: AFilterApiProtocol) {
        self.apiService = apiService
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
}

private extension SearchAccommodationViewModel {
    func bind() {
        bindOnAppear()
        bindOnUpdate()
    }
    
    func bindOnAppear() {
        let request = input.onAppear
            .handleEvents(receiveOutput: { [weak self] in
                self?.output.screenState = .loading
            })
            .map { [unowned self] in
                self.apiService.getFilter(type: self.output.filterSettings.type,
                                          rooms: self.output.filterSettings.rooms,
                                          beds: self.output.filterSettings.beds,
                                          capacity: self.output.filterSettings.capacity,
                                          priceTo: self.output.filterSettings.priceTo,
                                          priceFrom: self.output.filterSettings.priceFrom,
                                          offset: self.offset,
                                          count: self.count)
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
                self?.output.accommodations = $0
                self?.output.screenState = .loading
            }
            .store(in: &cancellable)
    }
    
    func bindOnUpdate() {
        let request = input.onUpdate
            .handleEvents(receiveOutput: { [weak self] in
                self?.offset += 10
                self?.count += 10
            })
            .map { [unowned self] in
                self.apiService.getFilter(type: self.output.filterSettings.type,
                                          rooms: self.output.filterSettings.rooms,
                                          beds: self.output.filterSettings.beds,
                                          capacity: self.output.filterSettings.capacity,
                                          priceTo: self.output.filterSettings.priceTo,
                                          priceFrom: self.output.filterSettings.priceFrom,
                                          offset: self.offset,
                                          count: self.count)
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
                self?.output.accommodations += $0
                self?.output.screenState = .loading
            }
            .store(in: &cancellable)
    }
    
    func bindTrailingTap() {
        input.onTrailingTap
            .sink { [weak self] in
                self?.output.showingFilter = true
            }
            .store(in: &cancellable)
    }
    
    func bindFilterSettings() {
        input.onSettingsUpdate
            .handleEvents(receiveOutput: { [weak self] in
                self?.output.filterSettings = $0
            })
            .delay(for: 0.25, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.output.showingFilter = false
            }
            .store(in: &cancellable)
    }
}

extension SearchAccommodationViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let onUpdate = PassthroughSubject<Void, Never>()
        
        let onTrailingTap = PassthroughSubject<Void, Never>()
        let onSettingsUpdate = PassthroughSubject<Filter, Never>()
    }
    
    struct Output {
        var screenState: ProcessingState = .loading
        var accommodations: [AccommodationSearchModel] = []
        
        var filterSettings: Filter = .empty
        var showingFilter = false
    }
}
