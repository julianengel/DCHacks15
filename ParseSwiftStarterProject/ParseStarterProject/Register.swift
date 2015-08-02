//
//  Register.swift
//  ParseStarterProject
//
//  Created by Julian Engel on 8/2/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class Register: UIViewController {
    
    @IBOutlet weak var EmailField : UITextField!
    @IBOutlet weak var PasswordField : UITextField!
    var username = ""
    var password = ""
  
    
    override func viewDidLoad() {
        username = EmailField.text
        PasswordField.secureTextEntry = true
         password = PasswordField.text
    }

    
    func register(){
        
        
        
        var myQuery = PFObject(className: "User")
        myQuery["username"] = username
        myQuery["password"] = password
        
        myQuery.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
        
    }
    
    func login()
    {
        
        if count(username) != 0 && count(password) != 0{
            
            PFUser.logInWithUsernameInBackground(username, password: password, block: nil)
            
        }
        
        
        
        
     
      
        
    }

}
