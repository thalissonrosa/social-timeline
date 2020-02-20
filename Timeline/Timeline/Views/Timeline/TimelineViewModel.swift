//
//  TimelineViewModel.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 17/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import Foundation
import RxSwift

final class TimelineViewModel {

    // MARK: - Properties
    
    let user: User
    let accountService: AccountService
    let timelineService: TimelineService
    private var posts: [Post] = []
    var numberOfPosts: Int {
        return posts.count
    }
    var newPosts: Observable<Post> {
        //Firebase will always return the most recent data but we already retrieved it earlier, so we can ignore the first value if posts.count > 0
        return timelineService.startLiveUpdating()
            .skip(posts.count > 0 ? 1 : 0)
            .do(onNext: { [weak self] post in
                self?.posts.insert(post, at: 0)
        })
    }
    var insertPostIndexPath: IndexPath {
        return IndexPath(item: 0, section: 0)
    }

    // MARK: - Init

    init(user: User,
         accountService: AccountService = FirebaseAccountService(),
         timelineService: TimelineService = FirebaseTimelineService()) {
        self.user = user
        self.accountService = accountService
        self.timelineService = timelineService
    }

    // MARK: - Functions

    func logout() -> Completable {
        return accountService.logout()
    }

    func canErasePostAt(index: Int) -> Bool {
        return posts[index].user == user.username
    }

    func postAt(index: Int) -> Post {
        return posts[index]
    }

    func removePostAt(index: Int) {
        posts.remove(at: index)
    }

    func retrieveAllPosts() -> Single<[Post]> {
        return timelineService.retrievePosts()
            .map { posts -> [Post] in
                return posts.sorted(by: { $0.timestamp > $1.timestamp })
            }.do(onSuccess: { [weak self] posts in
                self?.posts = posts
            })
    }
}
