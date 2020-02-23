//
//  TimelineViewModelTests.swift
//  TimelineTests
//
//  Created by Thalisson da Rosa on 23/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import RxBlocking
import RxSwift
import RxTest
@testable import Timeline
import XCTest

class TimelineViewModelTests: XCTestCase {

    var accountService: AccountService!
    var timelineService: TimelineService!
    var disposeBag: DisposeBag!
    var viewModel: TimelineViewModel!

    override func setUp() {
        accountService = AccountServiceMock()
        timelineService = TimelineServiceMock()
        disposeBag = DisposeBag()
        let user = MockedUser()
        viewModel = TimelineViewModel(user: user, accountService: accountService, timelineService: timelineService)
    }

    func testNewPosts() {
        let scheduler = TestScheduler(initialClock: 0)
        let sink = scheduler.createObserver(PostOperation.self)
        viewModel.newPosts.bind(to: sink).disposed(by: disposeBag)

        XCTAssertEqual(sink.events.count, 4) // ADDED 1, ADDED 2, REMOVED 1, COMPLETED
        guard let first = sink.events[0].value.element else {
            XCTFail("First post unavailable")
            return
        }
        XCTAssertEqual(first.index, 0)
        XCTAssertEqual(first.type, PostUpdateType.added)
        XCTAssertEqual(first.post.message, "message")
        XCTAssertEqual(first.post.user, "user1")

        guard let second = sink.events[1].value.element else {
            XCTFail("Second post unavailable")
            return
        }
        XCTAssertEqual(second.index, 0) // When posts are added, index is always 0, so they go to the top of the list
        XCTAssertEqual(second.type, PostUpdateType.added)
        XCTAssertEqual(second.post.message, "message")
        XCTAssertEqual(second.post.user, "user2")

        guard let third = sink.events[2].value.element else {
            XCTFail("Third post unavailable")
            return
        }
        XCTAssertEqual(third.index, 1)
        XCTAssertEqual(third.type, PostUpdateType.removed)
        XCTAssertEqual(third.post.message, "message")
        XCTAssertEqual(third.post.user, "user1")
    }

    func testRetrieveAllSources() throws {
        guard let posts = try viewModel.retrieveAllPosts().toBlocking().first() else {
            XCTFail("No posts available")
            return
        }
        // On the mocked service the posts are on an ascending order, so here it should be reversed
        var count = posts.count
        for post in posts {
            XCTAssertEqual(post.message, "message \(count)")
            XCTAssertEqual(post.user, "user \(count % 2)")
            XCTAssertEqual(post.timestamp, Double(count))
            XCTAssertEqual(post.databaseKey, "key\(count)")
            print("### ITEM \(count) OK!")
            count -= 1
        }
    }
}
