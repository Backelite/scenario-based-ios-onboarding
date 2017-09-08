//
//  OnboardingHelperTests.swift
//  MyTailorIsRich
//
//  Created by philippe.bernery on 08/09/2017.
//  Copyright © 2017 Backelite. All rights reserved.
//

import Foundation
import XCTest
import RxBlocking
import RxTest
@testable import MyTailorIsRich

final class OnboardingHelperTests: XCTestCase {

    func testICloudActivationScenario() {
        // Given
        var testOK = false
        let scenario = OnboardingHelper.iCloudActivationScenario()
        scenario.subscribe(onNext: { _ in
            testOK = true
        })

        // When
        AnalyticsHelper.instance.createDetailEvent.onNext(Date())
        AnalyticsHelper.instance.viewDetailEvent.onNext(Date())
        AnalyticsHelper.instance.viewMasterEvent.onNext()

        // Then
        XCTAssertTrue(testOK)
    }

}
