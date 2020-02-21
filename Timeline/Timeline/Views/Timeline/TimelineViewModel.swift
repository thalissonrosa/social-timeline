//
//  TimelineViewModel.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 17/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import Foundation
import RxSwift

typealias PostOperation = (post: Post, type: PostUpdateType, index: Int)

final class TimelineViewModel {

    // MARK: - Properties

    private var posts: [Post] = []
    private let insertIndex = 0
    let user: User
    let accountService: AccountService
    let timelineService: TimelineService
    var numberOfPosts: Int {
        return posts.count
    }
    var newPosts: Observable<PostOperation> {
        return timelineService.startLiveUpdating()
            .map({ [weak self] (post, type) -> PostOperation? in
                return self?.postOperation(from: post, type: type)
            }).compactMap { $0 }
            .do(onNext: { [weak self] postOperation in
                self?.updateDataSource(postOperation: postOperation)
            })
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

    func removePostAt(index: Int) -> Completable {
        return timelineService.removePost(posts[index])
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

// MARK: - Private functions
private extension TimelineViewModel {

    func postOperation(from post: Post, type: PostUpdateType) -> PostOperation? {
        switch type {
        case .added:
            return PostOperation(post: post, type: type, index: insertIndex)
        case .removed:
            guard let index = posts.firstIndex(where: { $0.databaseKey == post.databaseKey }) else {
                return nil
            }
            return PostOperation(post: post, type: type, index: index)
        }
    }

    func updateDataSource(postOperation: PostOperation) {
        switch postOperation.type {
        case .added:
            posts.insert(postOperation.post, at: 0)
        case .removed:
            posts.remove(at: postOperation.index)
        }
    }
}
