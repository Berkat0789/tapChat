//
//  ContainerViewWithShadow.swift
//  TapChat
//
//  Created by Berkat Bhatti  on 6/28/18.
//  Copyright © 2018 Berkat Bhatti . All rights reserved.
//

import UIKit
@IBDesignable

class ContainerViewWithShadow: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateView()
    }
    
    func updateView() {
        self.layer.cornerRadius = 3.0

    }

}
