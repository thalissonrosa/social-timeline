//
//  SignInViewModelTests.swift
//  TimelineTests
//
//  Created by Thalisson da Rosa on 23/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import RxSwift
import RxTest
@testable import Timeline
import XCTest

class SignInViewModelTests: XCTestCase {

    var service: AccountService!
    var disposeBag: DisposeBag!
    var viewModel: SignInViewModel!

    override func setUp() {
        service = AccountServiceMock()
        disposeBag = DisposeBag()
        viewModel = SignInViewModel(accountService: service)
    }

    func testSignInButtonEnabled() {
        let scheduler = TestScheduler(initialClock: 0)
        let emailSource = scheduler.createColdObservable([.next(5, "test@email.com"),
                                                          .completed(10)])
        let passwordSource = scheduler.createColdObservable([.next(6, "password"),
                                                             .completed(10)])
        let sink = scheduler.createObserver(Bool.self)

        emailSource.bind(to: viewModel.email).disposed(by: disposeBag)
        passwordSource.bind(to: viewModel.password).disposed(by: disposeBag)
        viewModel.isLoginButtonEnabled.bind(to: sink).disposed(by: disposeBag)
        scheduler.start()
        XCTAssertEqual(sink.events, [.next(0, false),
                                     .next(6, true)])
    }
}
