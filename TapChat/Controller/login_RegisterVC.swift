//
//  login_RegisterVC.swift
//  TapChat
//
//  Created by Berkat Bhatti  on 6/28/18.
//  Copyright © 2018 Berkat Bhatti . All rights reserved.
//

import UIKit
import Firebase

class login_RegisterVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var segmanetdView: UISegmentedControl!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var userProfile: roundedProfileView!
    
    //Var and arrays
    var seletedProfileImage: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addtaptoProfileimage()
        segmanetdView.selectedSegmentIndex = 1
        registerButton.setTitle(segmanetdView.titleForSegment(at: segmanetdView.selectedSegmentIndex), for: UIControlState.normal)
        
        
        

    }
//gestures and animations
    func addtaptoProfileimage() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileTap))
        self.userProfile.addGestureRecognizer(tap)
        userProfile.isUserInteractionEnabled = true
    }
//Handlers
    @objc func handleProfileTap() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
//Protocol conforming functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            userProfile.image = editedImage
            seletedProfileImage = editedImage
        } else {
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            userProfile.image = image
            seletedProfileImage = image
        }
        
        dismiss(animated: true, completion: nil)
    }
//Buttons/Acions
    @IBAction func segmentedValueChanged(_ sender: Any) {
        registerButton.setTitle(segmanetdView.titleForSegment(at: segmanetdView.selectedSegmentIndex), for: UIControlState.normal)
        
        //Change height of container view
        if segmanetdView.selectedSegmentIndex == 0 {
            containerViewHeight.constant = 100
            usernameField.isHidden = true
        } else {
            usernameField.isHidden = false
            containerViewHeight.constant = 150
        }
    }
    @IBAction func handleLoginRegister(_ sender: Any) {
        if segmanetdView.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            HandleRegister()
        }
    }
    
    
    func handleLogin() {
        guard let email = emailField.text, emailField.text != "" || emailField.text != nil else {return}
        guard let password = passwordField.text, passwordField.text != "" || passwordField.text != nil else {return}
        Auth.auth().signIn(withEmail: email, password: password) { (success, error) in
            if error != nil {
                print(error!)
            } else {
                self.dismiss(animated: true, completion: nil)
                print("UserLoggedIN")
            }
        }
    
    }
    
    
    func HandleRegister() {
        guard let name = usernameField.text , usernameField.text != "" || usernameField.text != nil else {return}
        guard let email = emailField.text, emailField.text != "" || emailField.text != nil else {return}
        guard let password = passwordField.text, passwordField.text != "" || passwordField.text != nil else {return}
        Auth.auth().createUser(withEmail: email, password: password) { (success, error) in
            if error != nil {
                print(error!)
            } else {
                let imageData = UIImageJPEGRepresentation(self.seletedProfileImage, 0.2)
                let uniqueImageID = NSUUID().uuidString
                StorageService.init().StorageReference_profileImages.child(uniqueImageID).putData(imageData!, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error!)
                    } else {
                        let image = metadata?.downloadURL()?.absoluteString
                        let userData = ["Email" : email, "userProfile": image!, "Provider": (Auth.auth().currentUser?.providerID)!, "UserName": name]
                        DataService.instance.addUserToDatabase(userID: (Auth.auth().currentUser?.uid)!, userData: userData)
                        self.dismiss(animated: true, completion: nil)
                    }
                })
                
            }
        }
    }
    
    

    
//View funtions
  
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
