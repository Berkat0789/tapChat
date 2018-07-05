//
//  Users.swift
//  TapChat
//
//  Created by Berkat Bhatti  on 7/5/18.
//  Copyright © 2018 Berkat Bhatti . All rights reserved.
//

import Foundation

class Users {
    
    private(set) public var userName: String?
    private(set) public var userEmail: String?
    private(set) public var userProfileimg: String?
    private(set) public var userID: String?

    
    init(username: String, email: String, image: String, id: String) {
        self.userName = username
        self.userEmail = email
        self.userProfileimg = image
        self.userID = id
    }

}
