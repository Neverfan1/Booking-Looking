//
//  RegistrationViewModel.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 10.05.2023.
//

import Foundation
import Combine
import CombineExt

final class RegistrationViewModel: ObservableObject {
    
    // MARK: - Services
    weak var router: RegistrationRouter?
    private let apiService: RegistraionApiProtocol
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(apiService: RegistraionApiProtocol,
         router: RegistrationRouter?) {
        self.apiService = apiService
        self.router = router
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
}

private extension RegistrationViewModel {
    func bind() {
        bindPhoneAndEmail()
        bindName()
        bindGender()
        bindSignUp()
    }
    
    func bindPhoneAndEmail() {
        input.onChangePhone
            .sink { [weak self] in
                self?.output.phoneNumber = $0
            }
            .store(in: &cancellable)
        
        input.onChangeEmail
            .sink { [weak self] in
                self?.output.email = $0
            }
            .store(in: &cancellable)
    }
    
    func bindName() {
        input.onChangeName
            .sink { [weak self] in
                self?.output.name = $0
            }
            .store(in: &cancellable)
        
        input.onChangeSurname
            .sink { [weak self] in
                self?.output.surname = $0
            }
            .store(in: &cancellable)
    }
    
    func bindGender() {
        input.onMaleTap
            .sink { [weak self] in
                self?.output.sex = $0
            }
            .store(in: &cancellable)
        
        input.onFemaleTap
            .sink { [weak self] in
                self?.output.sex = $0
            }
            .store(in: &cancellable)
    }
    
    func bindSignUp() {
        let request = input.onSignUpTap
            .handleEvents(receiveOutput: { [weak self] in
                self?.output.screenState = .loading
            })
            .map { [unowned self] in
                self.apiService.registration(phone: self.output.phoneNumber,
                                             surname: self.output.surname,
                                             name: self.output.name,
                                             sex: self.output.sex,
                                             email: self.output.email)
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

extension RegistrationViewModel: ViewModelProtocol {
    struct Input {
        let onChangePhone = PassthroughSubject<String, Never>()
        let onChangeSurname = PassthroughSubject<String, Never>()
        let onChangeName = PassthroughSubject<String, Never>()
        let onMaleTap = PassthroughSubject<Int, Never>()
        let onFemaleTap = PassthroughSubject<Int, Never>()
        let onChangeEmail = PassthroughSubject<String, Never>()
        let onSignUpTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var screenState: ProcessingState = .loaded
        
        var phoneNumber: String = ""
        var name: String = ""
        var surname: String = ""
        var sex: Int = 2
        var email: String = ""
        var isPersonalDataAgreed: Bool = false
        var isEmailsAgreed: Bool = false

        var hasFocusedPhoneNumber: Bool = false
        var hasFocusedName: Bool = false
        var hasFocusedSurname: Bool = false
        var hasFocusedEmail: Bool = false

        var hasEnteredName = false
        var hasEnteredSurname = false
    }
}
