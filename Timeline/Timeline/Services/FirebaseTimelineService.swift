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

    // MARK: - Functions

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
                reference.updateChildValues(
                    [Post.Keys.timestamp: Date.timeIntervalSinceReferenceDate]
                )
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
                let posts = postsDictionary.allKeys.map { anyKey -> Post? in
                    guard let key = anyKey as? String,
                        let postDictionary = postsDictionary.value(forKey: key) as? NSDictionary else {
                        return nil
                    }
                    return Post.fromDictionary(postDictionary, key: key)
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

    func startLiveUpdating() -> Observable<(post: Post, type: PostUpdateType) > {
        return Observable.merge([addedPosts(), removedPosts()])
    }

    func removePost(_ post: Post) -> Completable {
        guard let databaseKey = post.databaseKey else { return Completable.empty() }
        let reference = Database.database().reference(withPath: postsPath).child(databaseKey)
        return Completable.create { completable in
            reference.removeValue { (error, _) in
                guard error == nil else {
                    let appError = TimelineError(message: error?.localizedDescription,
                                                 errorCode: .timelineError)
                    completable(.error(appError))
                    return
                }
                completable(.completed)
            }
            return Disposables.create()
        }
    }
}

// MARK: Private functions

private extension FirebaseTimelineService {

    private func addedPosts() -> Observable<(post: Post, type: PostUpdateType)> {
        let reference = Database.database()
            .reference(withPath: postsPath)
        return Observable.create { observable in
            //For some reason, when using .childAdded Firebase send back all the values already on the database instead of just the ones that were added after the observer was created. The solution to make it easier is to observe .childChanged and, on createPost(), to update one of the values soon after adding it to the database
            reference.observe(.childChanged, with: { snapshot in
                guard let postDictionary = snapshot.value as? NSDictionary,
                    let post = Post.fromDictionary(postDictionary, key: snapshot.key) else { return }
                observable.on(.next((post: post, type: .added)))
            })
            return Disposables.create()
        }
    }

    private func removedPosts() -> Observable<(post: Post, type: PostUpdateType)> {
        let reference = Database.database()
            .reference(withPath: postsPath)
        return Observable.create { observable in
            reference.observe(.childRemoved, with: { snapshot in
                guard let postDictionary = snapshot.value as? NSDictionary,
                    let post = Post.fromDictionary(postDictionary, key: snapshot.key) else { return }
                observable.on(.next((post: post, type: .removed)))
            })
            return Disposables.create()
        }
    }
}
