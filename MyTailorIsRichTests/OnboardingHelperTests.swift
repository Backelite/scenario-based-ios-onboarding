//
//  OnboardingHelperTests.swift
//  MyTailorIsRich
//
//  Created by philippe.bernery on 08/09/2017.
//  Copyright © 2017 Backelite. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import RxBlocking
import RxTest
@testable import MyTailorIsRich

enum TestErrors: Error {
    case anyError
    case specificError
}

final class OnboardingHelperTests: XCTestCase {

    var scheduler: TestScheduler!
    var subscription: Disposable!

    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        super.tearDown()
        scheduler.scheduleAt(1000) { 
            self.subscription.dispose()
        }
    }

    func testICloudActivationScenario() {
        // Given
        let observer = scheduler.createObserver(Void.self)
        let scenario = OnboardingHelper.iCloudActivationScenario()

        // When
        _ = scenario.subscribe(observer)

        scheduler.scheduleAt(1) {
            AnalyticsHelper.instance.createDetailEvent.onNext(Date())
            AnalyticsHelper.instance.viewDetailEvent.onNext(Date())
            AnalyticsHelper.instance.viewMasterEvent.onNext()
        }
        scheduler.start()

        // Then
        XCTAssertEqual(observer.events.count, 2) // next and completed
    }

    func testICloudActivationScenarioDoesNotExecute() {
        // Given
        let observer = scheduler.createObserver(Void.self)
        let scenario = OnboardingHelper.iCloudActivationScenario()

        // When
        subscription = scenario.subscribe(observer)

        scheduler.scheduleAt(1) {
            AnalyticsHelper.instance.createDetailEvent.onNext(Date())
            AnalyticsHelper.instance.viewDetailEvent.onNext(Date())
            // Don't go back to master
            // AnalyticsHelper.instance.viewMasterEvent.onNext()

        }
        scheduler.start()

        // Then
        XCTAssertEqual(observer.events.count, 0)
    }


    func testICloudActivationScenarioDoesNotExecuteWithError() {
        // Given
        let observer = scheduler.createObserver(Void.self)
        let scenario = OnboardingHelper.iCloudActivationScenario()

        // When
        subscription = scenario.subscribe(observer)

        scheduler.scheduleAt(1) {
            AnalyticsHelper.instance.createDetailEvent.onNext(Date())
            AnalyticsHelper.instance.viewDetailEvent.onNext(Date())
             AnalyticsHelper.instance.viewMasterEvent.onError(TestErrors.anyError)
        }
        scheduler.start()

        // Then
        XCTAssertEqual(observer.events.count, 1)
        switch observer.events[0].value {
        case .error(let type):
            XCTAssertEqual(type as? TestErrors, TestErrors.anyError)
            XCTAssertNotEqual(type as? TestErrors, TestErrors.specificError)
        default:
            XCTFail()
        }
    }

}
