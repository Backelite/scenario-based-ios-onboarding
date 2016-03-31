//
//  StatsHelper.swift
//  MyTailorIsRich
//
//  Created by Philippe Bernery on 31/03/2016.
//  Copyright © 2016 Backelite. All rights reserved.
//

import Foundation
import RxSwift

class StatsHelper {

    let disposeBag = DisposeBag()

    init() {
        AnalyticsHelper.instance.viewMasterEvent
            .subscribeNext {
                print("event: view master")
            }
            .addDisposableTo(disposeBag)

        AnalyticsHelper.instance.createDetailEvent
            .subscribeNext { next in
                print("event: create detail - \(next)")
            }
            .addDisposableTo(disposeBag)

        AnalyticsHelper.instance.viewDetailEvent
            .subscribeNext { next in
                print("event: view detail - \(next)")
            }
            .addDisposableTo(disposeBag)
    }

}