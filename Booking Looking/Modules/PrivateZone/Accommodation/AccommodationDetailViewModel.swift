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
    private let apiService: ADetailApiProtocol
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - External
    private let id: Int
    
    init(id: Int, apiService: ADetailApiProtocol) {
        self.id = id
        self.apiService = apiService
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
}

private extension AccommodationDetailViewModel {
    func bind() {
        bindOnAppear()
        bindOnDateTap()
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
    
    func bindOnDateTap() {
        input.onDateTap
            .sink { [weak self] in
                self?.output.showingCalendar.toggle()
            }
            .store(in: &cancellable)
    }
}

extension AccommodationDetailViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let onDateTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var screenState: ProcessingState = .loading
        var accommodation: AccommodationDetailModel = .mock()
        var showingCalendar = false
    }
}
