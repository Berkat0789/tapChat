//
//  roundedProfileView.swift
//  TapChat
//
//  Created by Berkat Bhatti  on 6/28/18.
//  Copyright © 2018 Berkat Bhatti . All rights reserved.
//

import UIKit
@IBDesignable
class roundedProfileView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        updateview()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateview()
    }
    
    func updateview() {
        self.layer.cornerRadius = self.layer.frame.width / 2
        self.clipsToBounds = true
    }

}
