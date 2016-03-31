//
//  DetailViewController.swift
//  MyTailorIsRich
//
//  Created by Philippe Bernery on 31/03/2016.
//  Copyright © 2016 Backelite. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName(AnalyticsHelper.instance.viewDetailEvent,
                                                                  object: self,
                                                                  userInfo: ["value": detailItem!])
    }

}

