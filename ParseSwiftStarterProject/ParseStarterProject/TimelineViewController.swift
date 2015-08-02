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

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tabBarController?.delegate = self
  }
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        
    }

}

// MARK: Tab Bar Delegate

extension TimelineViewController: UITabBarControllerDelegate {

  func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
    if (viewController is UploadViewController) {
      println("Take Photo")
      return false
    } else {
      return true
    }
  }

}