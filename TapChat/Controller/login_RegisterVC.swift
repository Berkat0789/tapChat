//
//  login_RegisterVC.swift
//  TapChat
//
//  Created by Berkat Bhatti  on 6/28/18.
//  Copyright © 2018 Berkat Bhatti . All rights reserved.
//

import UIKit

class login_RegisterVC: UIViewController {
    @IBOutlet weak var segmanetdView: UISegmentedControl!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmanetdView.selectedSegmentIndex = 1
        registerButton.setTitle(segmanetdView.titleForSegment(at: segmanetdView.selectedSegmentIndex), for: UIControlState.normal)
        
        
        

    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
