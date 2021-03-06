//
//  homeVC.swift
//  TapChat
//
//  Created by Berkat Bhatti  on 6/28/18.
//  Copyright © 2018 Berkat Bhatti . All rights reserved.
//

import UIKit
import Firebase

class homeVC: UITableViewController {
    
//--Var and arrays
    var allusers = [Users]()
    var myData: Users!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Compose", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleCompose))
        checkifuserisLoggedin()
    }
    func checkifuserisLoggedin() {
        if Auth.auth().currentUser?.uid == nil {
            //Erorr - Warning Unbalanced calls to begin/end appearance transitions for <UINavigationController: 0x7fb24881e400> to fix this
            handleLogout()
        } else {
            fetchUserDataforMenutitle()
        }
    }
    
    func fetchUserDataforMenutitle(){
        DataService.instance.Firebase_Ref_Users.observe(DataEventType.value) { (userSnap) in
            DataService.instance.getDatafor(UserId: currentUserID) { (mydata) in
                self.navigationItem.title = mydata.userName
            }
        }
    }
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let loginRegisterVC = storyboard.instantiateViewController(withIdentifier: "login_RegisterVC") as? login_RegisterVC
            loginRegisterVC?.homeViewController = self
            present(loginRegisterVC!, animated: true, completion: nil)
        } catch let error as NSError {
            print(error)
        }
    }
    
    @objc func handleCompose() {
        let storybaoad = UIStoryboard(name: "Main", bundle: Bundle.main)
        let composeController = storybaoad.instantiateViewController(withIdentifier: "NewMessaageController") as! newMessageController
        let navCOntroller  = UINavigationController(rootViewController: composeController)
        present(navCOntroller, animated: true, completion: nil)
        
    }
//--Protocol functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? homeCell else {return UITableViewCell()}
        return cell
    }

}
