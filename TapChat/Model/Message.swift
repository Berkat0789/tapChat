//
//  Message.swift
//  TapChat
//
//  Created by Berkat Bhatti  on 7/8/18.
//  Copyright © 2018 Berkat Bhatti . All rights reserved.
//

import Foundation


class Message {
    
    private(set) public var messageContent: String?
    private(set) public var fromID: String?
    private(set) public var toID: String?
    private(set) public var timeStamp: Double?



    init(content: String, fromid: String, toID: String, timestamp: Double) {
        self.messageContent = content
        self.fromID = fromid
        self.toID = toID
        self.timeStamp = timestamp
    }
    
}
