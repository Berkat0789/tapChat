//
//  newMessageController.swift
//  TapChat
//
//  Created by Berkat Bhatti  on 7/5/18.
//  Copyright © 2018 Berkat Bhatti . All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class newMessageController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    
//Var and arrays
    var allusers = [Users]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleCancel))
        //Fetch all users
            DataService.instance.getallUsers { (returnedUsers) in
                self.allusers = returnedUsers
                self.tableView.reloadData()
            }
        
      
    }
    
//Protocol
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allusers.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "messageCell")
        let user = allusers[indexPath.row]
        cell.textLabel?.text = user.userName
        cell.detailTextLabel?.text = user.userEmail
        cell.imageView?.sd_setImage(with: URL(string: user.userProfileimg!), placeholderImage: UIImage(named: ""), options: [SDWebImageOptions.progressiveDownload, SDWebImageOptions.continueInBackground], completed: nil)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feedVC = storyboard?.instantiateViewController(withIdentifier: "FeedVC") as? FeedVC
        let user = allusers[indexPath.row]
        feedVC?.passedUser(user: user)
        let navController = UINavigationController(rootViewController: feedVC!)
        present(navController, animated: true, completion: nil)
    }
    
//Handlers
   @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }


}
