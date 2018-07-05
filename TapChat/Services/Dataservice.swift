//
//  Dataservice.swift
//  TapChat
//
//  Created by Berkat Bhatti  on 7/5/18.
//  Copyright © 2018 Berkat Bhatti . All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

let firebaseDBReference = Database.database().reference()
class DataService {
    
    static var instance  = DataService()
    
    private(set) public var Firebase_Referecne = firebaseDBReference
    private(set) public var Firebase_Ref_Users = firebaseDBReference.child("Users")
    
    
//--Adduser to Fdatabase
    func addUserToDatabase(userID: String, userData: Dictionary<String, Any>) {
        Firebase_Ref_Users.child(userID).updateChildValues(userData)
    }
    
//--Get all users
    func getallUsers(completed: @escaping (_ users: [Users]) -> ()) {
        var allusers = [Users]()
        Firebase_Ref_Users.observeSingleEvent(of: DataEventType.value) { (userSnap) in
            guard let userSnap = userSnap.children.allObjects as? [ DataSnapshot] else {return}
            for user in userSnap {
                let username = user.childSnapshot(forPath: "UserName").value as! String
                let email = user.childSnapshot(forPath: "Email").value as! String
                let userID = user.key
                let allUsers = Users(username: username, email: email, image: "", id: userID)
                allusers.append(allUsers)
            }
            completed(allusers)
        }
    }
//Get user Data
    func getDatafor(UserId: String, completed: @escaping (_ data: Users) -> ()) {
        var currentUserData: Users!
        Firebase_Ref_Users.observeSingleEvent(of: DataEventType.value) { (userSnap) in
            guard let userSnap = userSnap.children.allObjects as? [ DataSnapshot] else {return}
            for user in userSnap {
                let username = user.childSnapshot(forPath: "UserName").value as! String
                let email = user.childSnapshot(forPath: "Email").value as! String
                let userID = user.key
                let myData = Users(username: username, email: email, image: "", id: userID)
                currentUserData = myData
            }
            completed(currentUserData)
        }
    }
}
