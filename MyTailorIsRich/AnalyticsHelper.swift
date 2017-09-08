//
//  AnalyticsHelper.swift
//  MyTailorIsRich
//
//  Created by Philippe Bernery on 31/03/2016.
//  Copyright © 2016 Backelite. All rights reserved.
//

import Foundation
import RxSwift

class AnalyticsHelper {

    static let instance = AnalyticsHelper()

    let viewMasterEvent = PublishSubject<Void>()

    // Detail CRUD
    let createDetailEvent = PublishSubject<Date>()
    let viewDetailEvent = PublishSubject<Date>()

}
