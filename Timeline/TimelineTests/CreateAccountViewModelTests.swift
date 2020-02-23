//
//  CreateAccountViewModelTests.swift
//  TimelineTests
//
//  Created by Thalisson da Rosa on 23/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import RxSwift
import RxTest
@testable import Timeline
import XCTest

class CreateAccountViewModelTests: XCTestCase {

    var service: AccountService!
    var disposeBag: DisposeBag!
    var viewModel: CreateAccountViewModel!

    override func setUp() {
        service = AccountServiceMock()
        disposeBag = DisposeBag()
        viewModel = CreateAccountViewModel(accountService: service)
    }

    func testCreateAccountButtonEnabled() {
        let scheduler = TestScheduler(initialClock: 0)
        let emailSource = scheduler.createColdObservable([.next(5, "test@email.com"),
        .completed(10)])
        let passwordSource = scheduler.createColdObservable([.next(6, "password"),
                                                             .completed(10)])
        let confirmPasswordSource = scheduler.createColdObservable([.next(7, "password"),
                                                                    .completed(10)])

        let sink = scheduler.createObserver(Bool.self)

        emailSource.bind(to: viewModel.email).disposed(by: disposeBag)
        passwordSource.bind(to: viewModel.password).disposed(by: disposeBag)
        confirmPasswordSource.bind(to: viewModel.confirmPassword).disposed(by: disposeBag)
        viewModel.isCreateAccountButtonEnabled.bind(to: sink).disposed(by: disposeBag)
        scheduler.start()
        XCTAssertEqual(sink.events, [.next(0, false),
                                     .next(7, true)])
    }

    func testPasswordMatches() {
        let scheduler = TestScheduler(initialClock: 0)
        let passwordSource = scheduler.createColdObservable([.next(5, "password"), .completed(10)])
        let confirmPasswordSource = scheduler.createColdObservable([.next(5, "pass"), .next(7, "password"), .completed(10)])
        let sink = scheduler.createObserver(Bool.self)

        passwordSource.bind(to: viewModel.password).disposed(by: disposeBag)
        confirmPasswordSource.bind(to: viewModel.confirmPassword).disposed(by: disposeBag)
        viewModel.passwordMatches.bind(to: sink).disposed(by: disposeBag)
        scheduler.start()
        XCTAssertEqual(sink.events, [.next(0, true),
                                     .next(5, false),
                                     .next(7, true)])
    }
}
