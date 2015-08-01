//
//  PhotoTakingHelper.swift
//  Makestagram
//
//  Created by Benjamin Encz on 5/21/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

typealias PhotoTakingHelperCallback = UIImage? -> Void

class PhotoTakingHelper : NSObject {
  
  /** View controller on which View Controllers should be presented */
  weak var viewController: UIViewController!
  var successCallback: PhotoTakingHelperCallback
  var imagePickerController: UIImagePickerController?
  
  var presentedViewControllerStack: [UIViewController] = []
  
  init(viewController: UIViewController, successCallback: PhotoTakingHelperCallback) {
    self.viewController = viewController
    self.successCallback = successCallback
    
    super.init()
    
    showPhotoSourceSelection()
    presentedViewControllerStack.append(viewController)
  }
  

  
}