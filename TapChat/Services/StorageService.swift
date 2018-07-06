//
//  StorageService.swift
//  TapChat
//
//  Created by Berkat Bhatti  on 7/5/18.
//  Copyright © 2018 Berkat Bhatti . All rights reserved.
//

import Foundation
import Firebase

let Fir_Storafe_Ref = Storage.storage().reference()

class StorageService {
    static let instance = StorageService()
    
    private(set) public var StorageReference = Fir_Storafe_Ref
    private(set) public var StorageReference_profileImages = Fir_Storafe_Ref.child("ProfileImgs")

    
}
