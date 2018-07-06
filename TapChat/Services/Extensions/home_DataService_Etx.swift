//
//  home_DataService_Etx.swift
//  TapChat
//
//  Created by Berkat Bhatti  on 7/5/18.
//  Copyright © 2018 Berkat Bhatti . All rights reserved.
//

import Foundation
import Firebase

extension homeVC {
    
    func checkifuserisLoggedin() {
        if Auth.auth().currentUser?.uid == nil {
            //Erorr - Warning Unbalanced calls to begin/end appearance transitions for <UINavigationController: 0x7fb24881e400> to fix this
            performSelector(inBackground: #selector(handleLogout), with: nil)
        } else {
            DataService.instance.getDatafor(UserId: currentUserID) { (mydata) in
                self.myData = mydata
                self.navigationItem.title = self.myData.userName
            }
        }
    }
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print(error)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginRegisterVC = storyboard.instantiateViewController(withIdentifier: "login_RegisterVC") as? login_RegisterVC
        present(loginRegisterVC!, animated: true, completion: nil)
        
    }
    
    @objc func handleCompose() {
        let storybaoad = UIStoryboard(name: "Main", bundle: Bundle.main)
        let composeController = storybaoad.instantiateViewController(withIdentifier: "NewMessaageController") as! newMessageController
        let navCOntroller  = UINavigationController(rootViewController: composeController)
        present(navCOntroller, animated: true, completion: nil)
        
    }
}
