//
//  UserProfileViewModel.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 14.05.2023.
//

import Foundation
import Combine
import CombineExt

final class UserProfileViewModel: ObservableObject {
    // MARK: - Services
    private let apiService: ProfileApiProtocol
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    private let authState: CurrentValueSubject<AuthState, Never>
    
    init(apiService: ProfileApiProtocol, authState: CurrentValueSubject<AuthState, Never>) {
        self.apiService = apiService
        self.authState = authState
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
}

private extension UserProfileViewModel {
    func bind() {
        bindOnAppear()
        bindExitTap()
    }
    
    func bindOnAppear() {
        let request = input.onAppear
            .handleEvents(receiveOutput: { [weak self] in
                self?.output.screenState = .loading
            })
            .filter { LocalStorage.current.ID != 0 }
            .map { [unowned self] in
                self.apiService.getDetailInfo()
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
                self?.output.user = $0
                self?.output.screenState = .loaded
            }
            .store(in: &cancellable)
    }
    
    func bindExitTap() {
        input.onExitTap
            .sink { [weak self] in
                LocalStorage.current.token = ""
                LocalStorage.current.isComplited = false
                self?.authState.send(.unauthorized)
            }
            .store(in: &cancellable)
    }
}

extension UserProfileViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let onExitTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var screenState: ProcessingState = .loading
        var user: UserModel = .mock()
    }
}
