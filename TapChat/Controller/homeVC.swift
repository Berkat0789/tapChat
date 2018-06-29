//
//  homeVC.swift
//  TapChat
//
//  Created by Berkat Bhatti  on 6/28/18.
//  Copyright © 2018 Berkat Bhatti . All rights reserved.
//

import UIKit

class homeVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Compose", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleCompose))


    }
    
//Handlers
    @objc func handleLogout() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginRegisterVC = storyboard.instantiateViewController(withIdentifier: "login_RegisterVC") as? login_RegisterVC
        present(loginRegisterVC!, animated: true, completion: nil)
        
    }
    @objc func handleCompose() {
        
    }

}
