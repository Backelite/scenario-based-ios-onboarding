//
//  OnboardingHelper.swift
//  MyTailorIsRich
//
//  Created by Philippe Bernery on 31/03/2016.
//  Copyright © 2016 Backelite. All rights reserved.
//

import Foundation
import RxSwift

public class OnboardingHelper {

    let disposeBag = DisposeBag()

    init() {
        let iCloudActivationAsked = false
        if !iCloudActivationAsked {
            setupICloudActivationScenario()
        }
    }

    public class func iCloudActivationScenario() -> Observable<Void> {
        return AnalyticsHelper.instance.createDetailEvent
            .flatMap { _ in
                return AnalyticsHelper.instance.viewDetailEvent
            }
            .flatMap { _ in
                return AnalyticsHelper.instance.viewMasterEvent
            }
            .take(1)
    }

    private func setupICloudActivationScenario() {
        AnalyticsHelper.instance.createDetailEvent
            .flatMap { _ in
                return AnalyticsHelper.instance.viewDetailEvent
            }
            .flatMap { _ in
                return AnalyticsHelper.instance.viewMasterEvent
            }
            .take(1)
            .subscribe(onNext: { _ in
                let alert = UIAlertView(title: "iCloud", message: "Voulez-vous utiliser iCloud pour sauvegarder vos dates ?", delegate: nil, cancelButtonTitle: "Non", otherButtonTitles: "Oui")
                alert.show()
            })
            .addDisposableTo(disposeBag)
    }

}
