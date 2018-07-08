//
//  messageCell.swift
//  TapChat
//
//  Created by Berkat Bhatti  on 7/8/18.
//  Copyright © 2018 Berkat Bhatti . All rights reserved.
//

import UIKit
import Foundation
import Firebase
import SDWebImage

class messageCell: UITableViewCell {
    @IBOutlet weak var userProfile: roundedProfileView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var messageContent: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    
    func updateCell(message: Message) {
        let timestampinSeconds = NSDate(timeIntervalSince1970: message.timeStamp!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        timestamp.text = dateFormatter.string(from: timestampinSeconds as Date)
        self.messageContent.text = message.messageContent
        DataService.instance.getDatafor(UserId: message.fromID!) { (myData) in
            self.userName.text = myData.userName
            self.userProfile.sd_setImage(with: URL(string: myData.userProfileimg!), placeholderImage: UIImage(named: "mary"), options: SDWebImageOptions.progressiveDownload, completed: nil)
        }
    }

}
