//
//  roundedShadowViewForCells.swift
//  TapChat
//
//  Created by Berkat Bhatti  on 7/8/18.
//  Copyright © 2018 Berkat Bhatti . All rights reserved.
//

import UIKit
@IBDesignable

class roundedShadowViewForCells: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateView()
    }
    func updateView() {
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.clipsToBounds = true
        self.layer.shadowOpacity = 0.3
        
    }

}
