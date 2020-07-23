//
//  SignInViewModel.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 15/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import RxCocoa
import RxSwift

final class SignInViewModel {

    private let accountService: AccountService
    var email = BehaviorRelay<String?>(value: "")
    var password = BehaviorRelay<String?>(value: "")
    var isLoginButtonEnabled: Observable<Bool> {
      return Observable.combineLatest(email.asObservable(),
                                      password.asObservable()) { email, password in
            let emailCount = email?.count ?? 0
            let passwordCount = password?.count ?? 0
            return emailCount > 0 &&  passwordCount > 0
        }.distinctUntilChanged()
    }

    init(accountService: AccountService = FirebaseAccountService()) {
        self.accountService = accountService
    }

    func login() -> Single<User> {
        guard let email = email.value, let password = password.value else {
            let error = TimelineError(message: AppStrings.missingEmailPassword.localized,
                                      errorCode: .genericError)
            return Single.error(error)
        }
        return accountService.signIn(username: email, password: password)
    }
}
