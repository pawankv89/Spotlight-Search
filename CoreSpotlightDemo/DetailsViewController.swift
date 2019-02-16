//
//  DetailsViewController.swift
//  CoreSpotlightDemo
//
//  Created by Pawan kumar on 16/02/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var printerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var titleString: String = ""
    var subtitleString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.titleLabel.text = self.titleString
        self.subtitleLabel.text = self.subtitleString
        
    }
}
