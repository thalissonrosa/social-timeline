//
//  CreateAccountViewModel.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 15/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class CreateAccountViewModel {

    // MARK: - Properties
    private let accountService: AccountService
    var email = BehaviorRelay<String?>(value: "")
    var password = BehaviorRelay<String?>(value: "")
    var confirmPassword = BehaviorRelay<String?>(value: "")
    var isCreateAccountButtonEnabled: Observable<Bool> {
        return Observable.combineLatest(email.asObservable(),
                                        password.asObservable(),
                                        passwordMatches) { email, password, matchingPassword in
            let emailCount = email?.count ?? 0
            let passwordCount = password?.count ?? 0
            return emailCount > 0 && passwordCount > 0 && matchingPassword
        }.distinctUntilChanged()
    }
    var passwordMatches: Observable<Bool> {
        return Observable.combineLatest(password.asObservable(),
                                        confirmPassword.asObservable()) { password, confirmation in
            return password == confirmation
        }
    }

    // MARK: Init

    init(accountService: AccountService = FirebaseAccountService()) {
        self.accountService = accountService
    }

    // MARK: Public functions

    func createAccount() -> Completable {
        guard let email = email.value,
            let password = password.value,
            let confirmPassword = confirmPassword.value else {
                let error = TimelineError(message: AppStrings.missingEmailPassword.localized,
                                          errorCode: .genericError)
                return Completable.error(error)
        }
        guard password == confirmPassword else {
            let error = TimelineError(message: AppStrings.passwordMismatch.localized,
                                      errorCode: .genericError)
            return Completable.error(error)
        }
        return accountService.createAccount(username: email,
                                            password: password,
                                            confirmPassword: confirmPassword)
    }
}
