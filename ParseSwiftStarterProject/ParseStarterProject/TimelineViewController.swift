//
//  TimelineViewController.swift
//  Makestagram
//
//  Created by Benjamin Encz on 5/21/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse


import UIKit

class TimelineViewController: UIViewController {

    var photoTakingHelper: PhotoTaker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "baraa"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println("Object has been saved again.")
        }
        
         super.viewDidLoad()
        self.tabBarController?.delegate = self
    }
    
}

// MARK: Tab Bar Delegate

extension TimelineViewController: UITabBarControllerDelegate {
    
    
      
        func takePhoto() {
            // instantiate photo taking class, provide callback for when photo  is selected
            PhotoTaker(viewController: self.tabBarController!, callback: { (image: UIImage?) in let imageData = UIImageJPEGRepresentation(image, 0.8)
                let imageFile = PFFile(data: imageData)
                imageFile.save()
                
                let post = PFObject(className: "Post")
                post["image"] = imageFile
                post.save()
                println("sucess")
                // don't do anything, yet...
            })
    
    }


    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is PhotoViewController) {
            takePhoto()
            return false
        } else {
            return true
        }
    }
    
        
}