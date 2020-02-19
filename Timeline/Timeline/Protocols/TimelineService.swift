//
//  TimelineService.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 18/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import RxSwift

protocol TimelineService {

    func createPost(_ post, from: User) -> Completable
    func retrievePosts() -> Observable<[Post]>
}