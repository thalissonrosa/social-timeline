//
//  FirebaseTimelineService.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 18/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import FirebaseDatabase
import RxSwift

struct FirebaseTimelineService: TimelineService {

    private let postsPath = "posts"

    func createPost(_ message: String, from user: User) -> Completable {
        let post = Post(message: message,
                        user: user.username,
                        timestamp: Date.timeIntervalSinceReferenceDate)
        let reference = Database.database().reference(withPath: postsPath)
        let postRef = reference.childByAutoId()
        return Completable.create { completable in
            postRef.setValue(post.toAnyObject()) { (error, reference) in
                guard error == nil else {
                    let error = TimelineError(message: error?.localizedDescription,
                                              errorCode: .timelineError)
                    completable(.error(error))
                    return
                }
                completable(.completed)
            }
            return Disposables.create()
        }
    }

    func retrievePosts() -> Single<[Post]> {
        let reference = Database.database().reference(withPath: postsPath)
        return Single.create { single in
            reference.observeSingleEvent(of: .value, with: { snapshot in
                guard let postsDictionary = snapshot.value as? NSDictionary else {
                    // This means that the timeline is empty, so we return an empty array
                    single(.success([]))
                    return
                }
                let posts = postsDictionary.allValues.map { post -> Post? in
                    guard let postDictionary = post as? NSDictionary else {
                        return nil
                    }
                    return Post.fromDictionary(postDictionary)
                }.compactMap { $0 }
                single(.success(posts))
            }) { error in
                let appError = TimelineError(message: error.localizedDescription,
                                             errorCode: .timelineError)
                single(.error(appError))
            }
            return Disposables.create()
        }
    }

    func startLiveUpdating() -> Observable<Post> {
        let reference = Database.database().reference(withPath: postsPath)
        return Observable.create { observable in
            reference.queryLimited(toLast: 1).observe(.childAdded, with: { snapshot in
                guard let postDictionary = snapshot.value as? NSDictionary,
                    let post = Post.fromDictionary(postDictionary) else { return }
                observable.on(.next(post))
            }) { error in
                let appError = TimelineError(message: error.localizedDescription,
                                          errorCode: .timelineError)
                observable.on(.error(appError))
            }
            return Disposables.create()
        }
    }
}
