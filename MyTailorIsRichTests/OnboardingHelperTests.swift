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

final class OnboardingHelperTests: XCTestCase {

    func testICloudActivationScenario() {
        let scenarioDidFinish = expectation(description: "scenario did finish")

        // Given
        let scenario = OnboardingHelper.iCloudActivationScenario()
        _ = scenario
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
            scenarioDidFinish.fulfill()
        })

        // When
        DispatchQueue.global(qos: .background).async {
            AnalyticsHelper.instance.createDetailEvent.onNext(Date())
            AnalyticsHelper.instance.viewDetailEvent.onNext(Date())
            AnalyticsHelper.instance.viewMasterEvent.onNext()
        }

        // Then
        wait(for: [scenarioDidFinish], timeout: 3)
    }

}
