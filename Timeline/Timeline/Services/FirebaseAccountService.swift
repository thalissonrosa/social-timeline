//
//  FirebaseAccountService.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 15/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import FirebaseAuth
import RxCocoa
import RxSwift

struct FirebaseAccountService: AccountService {

    func signIn(username: String, password: String) -> Single<User> {
        return Single.create { single in
            Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
                guard let responseUser = result?.user else {
                    let error = TimelineError(message: error?.localizedDescription,
                                              errorCode: .authError)
                    single(.error(error))
                    return
                }
                let firebaseUser = FirebaseUser(user: responseUser)
                single(.success(firebaseUser))
            }
            return Disposables.create()
        }
    }

    func createAccount(username: String, password: String, confirmPassword: String) -> Completable {
        return Completable.create { completable in
            Auth.auth().createUser(withEmail: username, password: password) { (result, error) in
                guard result != nil else {
                    let error = TimelineError(message: error?.localizedDescription,
                                              errorCode: .authError)
                    completable(.error(error))
                    return
                }
                completable(.completed)
            }
            return Disposables.create()
        }
    }

    func logout() -> Completable {
        return Completable.create { completable in
            do {
                try Auth.auth().signOut()
                completable(.completed)
            } catch {
                let timelineError = TimelineError(message: error.localizedDescription, errorCode: .authError)
                completable(.error(timelineError))
            }
            return Disposables.create()
        }
    }
}
