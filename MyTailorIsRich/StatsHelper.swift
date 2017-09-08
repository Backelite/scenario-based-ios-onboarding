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
            .subscribe(onNext: { _ in
                print("event: view master")
            })
            .addDisposableTo(disposeBag)

        AnalyticsHelper.instance.createDetailEvent
            .subscribe(onNext: { date in
                print("event: create detail - \(date)")
            })
            .addDisposableTo(disposeBag)

        AnalyticsHelper.instance.viewDetailEvent
            .subscribe(onNext: { date in
                print("event: view detail - \(date)")
            })
            .addDisposableTo(disposeBag)
    }

}
