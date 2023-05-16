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
    weak var router: SearchAccommodationRouter?
    private let apiService: AFilterApiProtocol
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Internal
    private var offset = 0
    private var count = 10
    
    init(apiService: AFilterApiProtocol,
         router: SearchAccommodationRouter?) {
        self.apiService = apiService
        self.router = router
        
        self.input = Input()
        self.output = Output()
        // TODO: pag
        bind()
    }
}

private extension SearchAccommodationViewModel {
    func bind() {
        bindOnAppear()
        bindOnUpdate()
        bindOnCellTap()
        bindTrailingTap()
        bindFilterSettings()
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
                self?.output.screenState = .loaded
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
            }
            .store(in: &cancellable)
    }
    
    func bindOnCellTap() {
        input.onCellTap
            .sink { [weak self] in
                self?.router?.pushToDetails(id: $0)
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
        input.onTypeChange
            .sink { [weak self] in
                self?.output.filterSettings.type = $0
            }
            .store(in: &cancellable)
        
        input.onRoomsChange
            .sink { [weak self] in
                if $0 != 0 {
                    self?.output.filterSettings.rooms = $0
                } else {
                    self?.output.filterSettings.rooms = nil
                }
            }
            .store(in: &cancellable)
        
        input.onBedsChange
            .sink { [weak self] in
                if $0 != 0 {
                    self?.output.filterSettings.beds = $0
                } else {
                    self?.output.filterSettings.beds = nil
                }
            }
            .store(in: &cancellable)
        
        input.onCapacityChange
            .sink { [weak self] in
                if $0 != 0 {
                    self?.output.filterSettings.capacity = $0
                } else {
                    self?.output.filterSettings.capacity = nil
                }
            }
            .store(in: &cancellable)
        
        input.onPriceFromChange
            .sink { [weak self] in
                if $0 != 0 {
                    self?.output.filterSettings.priceFrom = $0
                } else {
                    self?.output.filterSettings.priceFrom = nil
                }
            }
            .store(in: &cancellable)
        
        input.onPriceToChange
            .sink { [weak self] in
                if $0 != 0 {
                    self?.output.filterSettings.priceTo = $0
                } else {
                    self?.output.filterSettings.priceTo = nil
                }
            }
            .store(in: &cancellable)
        
        input.onSettingsSave
            .delay(for: 0.25, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.output.showingFilter = false
                self?.input.onAppear.send()
            }
            .store(in: &cancellable)
    }
}

extension SearchAccommodationViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let onUpdate = PassthroughSubject<Void, Never>()
        let onCellTap = PassthroughSubject<Int, Never>()
        let onTrailingTap = PassthroughSubject<Void, Never>()
        
        let onTypeChange = PassthroughSubject<String, Never>()
        let onRoomsChange = PassthroughSubject<Int, Never>()
        let onBedsChange = PassthroughSubject<Int, Never>()
        let onCapacityChange = PassthroughSubject<Int, Never>()
        let onPriceToChange = PassthroughSubject<Int, Never>()
        let onPriceFromChange = PassthroughSubject<Int, Never>()
        
        let onSettingsSave = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var screenState: ProcessingState = .loading
        var accommodations: [AccommodationSearchModel] = []
        
        var type: String = ""
        var rooms: Int = 0
        var beds: Int = 0
        var capacity: Int = 0
        var priceTo: Int = 0
        var priceFrom: Int = 0
        
        var filterSettings: Filter = .empty
        var showingFilter = false
    }
}
