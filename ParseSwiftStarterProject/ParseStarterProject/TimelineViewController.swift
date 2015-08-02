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
        
        self.tabBarController?.delegate = self
    }
    
}

// MARK: Tab Bar Delegate

extension TimelineViewController: UITabBarControllerDelegate {
    
    func takePhoto() {
        // instantiate photo taking class, provide callback for when photo  is selected
        photoTakingHelper = PhotoTaker(viewController: self.tabBarController!) { (image: UIImage?) in
            // don't do anything, yet...
        }
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