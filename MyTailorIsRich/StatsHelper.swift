//
//  StatsHelper.swift
//  MyTailorIsRich
//
//  Created by Philippe Bernery on 31/03/2016.
//  Copyright © 2016 Backelite. All rights reserved.
//

import Foundation

class StatsHelper {

    init() {
        NSNotificationCenter.defaultCenter().addObserverForName(AnalyticsHelper.instance.viewMasterEvent, object: nil, queue: NSOperationQueue.mainQueue()) { notification in
            print("event: view master")
        }

        NSNotificationCenter.defaultCenter().addObserverForName(AnalyticsHelper.instance.createDetailEvent, object: nil, queue: NSOperationQueue.mainQueue()) { notification in
            print("event: create detail - \(notification.userInfo!["value"]! as! NSDate)")
        }

        NSNotificationCenter.defaultCenter().addObserverForName(AnalyticsHelper.instance.viewDetailEvent, object: nil, queue: NSOperationQueue.mainQueue()) { notification in
            print("event: view detail - \(notification.userInfo!["value"]! as! NSDate)")
        }
    }

}