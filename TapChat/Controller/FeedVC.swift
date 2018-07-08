//
//  FeedVC.swift
//  TapChat
//
//  Created by Berkat Bhatti  on 7/8/18.
//  Copyright © 2018 Berkat Bhatti . All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    //var and arrys
    var passedUSER : Users?
    var UserMessages = [Message]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handlebackPressed))
        navigationItem.title = self.passedUSER?.userName
        
        DataService.instance.Firebase_Ref_message.observe(DataEventType.value) { (messageSnap) in
            DataService.instance.getMessageforuserId() { (returnedMessages) in
                self.UserMessages = returnedMessages
                self.tableView.reloadData()
                
            }
        }

    }
    //protocol functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserMessages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? messageCell else {return UITableViewCell()}
        let message = UserMessages[indexPath.row]
        cell.updateCell(message: message)
        return cell
    }
    //actions
    @IBAction func sendPressed(_ sender: Any) {
        let timestamp: Double = NSDate().timeIntervalSince1970
        DataService.instance.sendMessagetoDb(messageCOntent: messageField.text!, FromId: currentUserID, toID: (passedUSER?.userID!)!, timestamp: timestamp) { (success) in
            if success {
                self.messageField.text = ""
                self.view.endEditing(true)
            }
          
        }
    }
    //Handlers
    @objc func handlebackPressed() {
        dismiss(animated: true, completion: nil)
    }

    //View function
    func passedUser(user: Users) {
        self.passedUSER = user
    }

}
