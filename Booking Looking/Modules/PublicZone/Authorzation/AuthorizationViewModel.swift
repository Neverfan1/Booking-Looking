//
//  AuthorizationViewModel.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 14.05.2023.
//

import Foundation
import Combine
import CombineExt

final class AuthorizationViewModel: ObservableObject {
    // MARK: - Services
    weak var router: AuthorizationRouter?
    private let apiService: AuthorizationApiProtocol
    
    // MARK: Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(apiService: AuthorizationApiProtocol,
         router: AuthorizationRouter?) {
        self.apiService = apiService
        self.router = router
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
}

private extension AuthorizationViewModel {
    func bind() {
        input.onChangeEmail
            .sink { [weak self] in
                self?.output.email = $0
            }
            .store(in: &cancellable)
        bindSignInTap()
    }
    
    func bindSignInTap() {
        let request = input.onSignInTap
            .handleEvents(receiveOutput: { [weak self] in
                self?.output.screenState = .loading
            })
            .map { [unowned self] in
                self.apiService.authorize(email: self.output.email)
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
            .sink { [weak self] response in
                LocalStorage.current.ID = Int(response.userId)
                self?.router?.pushToCode()
            }
            .store(in: &cancellable)
    }
}

extension AuthorizationViewModel {
    struct Input {
        let onChangeEmail = PassthroughSubject<String, Never>()
        let onSignInTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var screenState: ProcessingState = .loaded
        
        var email: String = ""
    }
}
