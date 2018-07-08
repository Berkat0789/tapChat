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
    private(set) public var Firebase_Ref_message = firebaseDBReference.child("Message")

    
    
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
                let profileURL = user.childSnapshot(forPath: "userProfile").value as! String
                let userID = user.key
                let allUsers = Users(username: username, email: email, image: profileURL, id: userID)
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
                let profileURL = user.childSnapshot(forPath: "userProfile").value as! String
                let userID = user.key
                let myData = Users(username: username, email: email, image: profileURL, id: userID)
                currentUserData = myData
            }
            completed(currentUserData)
        }
    }
//Send message to Firebase
    func sendMessagetoDb(messageCOntent: String, FromId: String, toID: String, timestamp: Double, compelted: @escaping (_ status: Bool) -> ()) {
        Firebase_Ref_message.childByAutoId().updateChildValues(["Content": messageCOntent, "fromID": FromId, "toID": toID, "timeStamp": timestamp])
        compelted(true)
    }
//func get messages for user
    func getMessageforuserId(completed: @escaping (_ messages: [Message]) -> ()) {
        var userMessages = [Message]()
        DataService.instance.Firebase_Ref_message.observeSingleEvent(of: DataEventType.value) { (messageSnap) in
            guard let messageSnap = messageSnap.children.allObjects as? [DataSnapshot] else {return}
            for messages in messageSnap {
                    let toId = messages.childSnapshot(forPath: "toID").value as! String
                    let content = messages.childSnapshot(forPath: "Content").value as! String
                    let FromID = messages.childSnapshot(forPath: "fromID").value as! String
                    let timestamp = messages.childSnapshot(forPath: "timeStamp").value as! Double
                    let messge = Message(content: content, fromid: FromID, toID: toId, timestamp: timestamp)
                    userMessages.append(messge)
            }
            completed(userMessages)
        }
        
    }
    
}
