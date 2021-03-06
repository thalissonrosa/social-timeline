//
//  TimelineService.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 18/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import RxSwift

protocol TimelineService {

    func createPost(_ message: String, from user: User) -> Completable
    func retrievePosts() -> Single<[Post]>
    func startLiveUpdating() -> Observable<(post: Post, type: PostUpdateType)>
    func removePost(_ post: Post) -> Completable
}
