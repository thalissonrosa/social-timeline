//
//  AccountService.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 15/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import RxSwift
import RxCocoa

protocol AccountService {

    func signIn(username: String, password: String) -> Observable<User>
    func createAccount(username: String, password: String, confirmPassword: String) -> Completable 
}
