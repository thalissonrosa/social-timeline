//
//  TimelineServiceMock.swift
//  TimelineTests
//
//  Created by Thalisson da Rosa on 23/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import RxSwift
import RxTest
import UIKit
@testable import Timeline

class TimelineServiceMock: TimelineService {

    func createPost(_ message: String, from user: User) -> Completable {
        return Completable.empty()
    }

    func retrievePosts() -> Single<[Post]> {
        var posts: [Post] = []
        for value in 1...5 {
            let post = Post(message: "message \(value)", user: "user \(value % 2)", timestamp: Double(value), databaseKey: "key\(value)")
            posts.append(post)
        }
        return Single.just(posts)
    }

    func startLiveUpdating() -> Observable<(post: Post, type: PostUpdateType)> {
        return Observable.create { observer in
            let postOne = Post(message: "message", user: "user1", timestamp: 1.0, databaseKey: "key")
            let postTwo = Post(message: "message", user: "user2", timestamp: 2.0, databaseKey: "key2")
            let addedPostOne = (post: postOne, type: PostUpdateType.added)
            let addedPostTwo = (post: postTwo, type: PostUpdateType.added)
            let removedPost = (post: postOne, type: PostUpdateType.removed)
            observer.on(.next(addedPostOne))
            observer.on(.next(addedPostTwo))
            observer.on(.next(removedPost))
            observer.on(.completed)
            return Disposables.create()
        }
    }

    func removePost(_ post: Post) -> Completable {
        return Completable.empty()
    }


}
