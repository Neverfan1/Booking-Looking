//
//  EnterCodeViewModel.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 14.05.2023.
//

import Foundation
import Combine
import CombineExt

final class EnterCodeViewModel: ObservableObject {
    // MARK: - Services
    weak var router: EnterCodeRouter?
    private let apiService: CodeApiProtocol
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(apiService: CodeApiProtocol, router: EnterCodeRouter?) {
        self.apiService = apiService
        self.router = router
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
}

private extension EnterCodeViewModel {
    func bind() {
        bindCode()
        bindConfirm()
    }
    
    func bindCode() {
        input.onChangeCode
            .handleEvents(receiveOutput: { [weak self] string in
                if string.count == 4 {
                    self?.output.isButtonEnabled = true
                } else {
                    self?.output.isButtonEnabled = false
                }
            })
            .sink { [weak self] in
                self?.output.code = $0
            }
            .store(in: &cancellable)
    }
    
    func bindConfirm() {
        
        let id = LocalStorage.current.ID
        
        let request = input.onConfirmTap
            .filter { id != 0 }
            .map { [unowned self] in
                self.apiService.checkCode(user: id,
                                          code: self.output.code)
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
                LocalStorage.current.token = $0.token
                LocalStorage.current.ID = $0.userId
                LocalStorage.current.isComplited = true
                print("closed")
                self?.router?.close()
            }
            .store(in: &cancellable)
    }
}

extension EnterCodeViewModel {
    struct Input {
        let onChangeCode = PassthroughSubject<String, Never>()
        let onConfirmTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var screenState: ProcessingState = .loaded
        
        var code: String = ""
        var isButtonEnabled = false
    }
}
