//
//  AccountServiceMock.swift
//  TimelineTests
//
//  Created by Thalisson da Rosa on 23/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import RxSwift
@testable import Timeline

class AccountServiceMock: AccountService {

    func signIn(username: String, password: String) -> Single<User> {
        let user = MockedUser()
        return Single.just(user)
    }

    func createAccount(username: String, password: String, confirmPassword: String) -> Completable {
        return Completable.empty()
    }

    func logout() -> Completable {
        return Completable.empty()
    }
}

class MockedUser: User {

    var username: String
    var identifier: String

    init() {
        username = "testUsername"
        identifier = "testIdentifier"
    }
}
