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

    
    func register(){
        
        let username = EmailField.text
        PasswordField.secureTextEntry = true
        let password = PasswordField.text
        
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


}
