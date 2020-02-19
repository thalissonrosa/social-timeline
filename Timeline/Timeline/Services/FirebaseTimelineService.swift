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
        let post = Post(message: message, user: user.username)
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

    func retrievePosts() -> Observable<[Post]> {
        let reference = Database.database().reference(withPath: postsPath)
        return Observable.create { observable in
            reference.observeSingleEvent(of: .value, with: { snapshot in
                guard let postsDictionary = snapshot.value as? NSDictionary else { return }
                let posts = postsDictionary.allValues.map { post -> Post? in
                    guard let postDictionary = post as? NSDictionary else { return nil }
                    return Post.fromDictionary(postDictionary)
                }.compactMap { $0 }
                observable.on(.next(posts))
            }) { error in
                observable.on(.error(error))
            }
            return Disposables.create()
        }
    }
}
