//
//  OwnerProfileViewModel.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 17.05.2023.
//

import Foundation
import Combine
import CombineExt

final class OwnerProfileViewModel: ObservableObject {
    // MARK: - Services
    weak var router: OwnerProfileRouter?
    private let apiService: CommonOwnerApiProtocol
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(id: (Int, Int), apiService: CommonOwnerApiProtocol, router: OwnerProfileRouter?) {
        self.apiService = apiService
        self.router = router
        
        self.input = Input()
        self.output = Output(id: id.0, lastAccomId: id.1)
        
        bind()
    }
}

private extension OwnerProfileViewModel {
    func bind() {
        let request = input.onAppear
            .handleEvents(receiveOutput: { [weak self] in
                self?.output.screenState = .loading
            })
            .map { [unowned self] in
                self.apiService.getOwnerDetail(id: self.output.id)
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
                self?.output.owner = $0
                self?.input.onSecondRequest.send()
            }
            .store(in: &cancellable)
        
        let sndRequest = input.onSecondRequest
            .handleEvents(receiveOutput: { [weak self] in
                self?.output.screenState = .loading
            })
            .map { [unowned self] in
                self.apiService.getOwnerAccommodations(id: self.output.id)
                    .materialize()
            }
            .switchToLatest()
            .share()
        
        sndRequest
            .failures()
            .sink { [weak self] error in
                self?.output.screenState = .error(message: error.localizedDescription)
            }
            .store(in: &cancellable)
        
        sndRequest
            .values()
            .sink { [weak self] in
                self?.output.accommodations = $0
                self?.output.screenState = .loaded
            }
            .store(in: &cancellable)
        
        bindOnAccomTap()
    }
    
    func bindOnAccomTap() {
        input.onAccomTap
            .sink { [weak self] id in
                guard let self = self else { return }
                
                if self.output.lastAccomId == id {
                    self.router?.back()
                } else {
                    self.router?.pushToDetail(id: id)
                }
            }
            .store(in: &cancellable)
    }
}

extension OwnerProfileViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let onSecondRequest = PassthroughSubject<Void, Never>()
        let onAccomTap = PassthroughSubject<Int, Never>()
    }
    
    struct Output {
        var id: Int
        var lastAccomId: Int
        var screenState: ProcessingState = .loading
        var owner: OwnerModel = .mock()
        var accommodations: [AccommodationSearchModel] = []
    }
}
