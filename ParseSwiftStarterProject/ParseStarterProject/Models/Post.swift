//
//  Post.swift
//  Makestagram
//
//  Created by Eric Kim on 6/26/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import Parse
import Bond

class Post: PFObject, PFSubclassing {
    
    var image: Dynamic<UIImage?> = Dynamic(nil)
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: PFUser?
    var photoUploadTask: UIBackgroundTaskIdentifier?
    var likes = Dynamic<[PFUser]?>(nil)
    
    //MARK: Subclassing Protocol
    
    //connect Parse class to Swift class
    static func parseClassName() -> String {
        return "Post"
    }
    
    //pure boilerplate code for init/initialize, used for all custom Parse class
    override init() {
        super.init()
    }
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            //inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
    //boilerplate background-upload code
    func uploadPost() {
        //we need to use image.value since image is Dynamic
        let imageData = UIImageJPEGRepresentation(image.value, 0.8)
        let imageFile = PFFile(data: imageData)
        
        //photoUploadTask stores the ID for the background task, which must be cancelled if the extra time expires
        photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { ()  -> Void in
            UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
        }
        
        //the save's argument is a callback that runs when the upload is done; in this case, ending the background task
        imageFile.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
        }
        
        //must set Post object's fields to their values; for imageFile, a separate instance variable was created
        user = PFUser.currentUser()
        self.imageFile = imageFile
        saveInBackgroundWithBlock(nil)
    }
    
    func downloadImage() {
        //check if the image has been downloaded yet
        if image.value == nil {
            imageFile?.getDataInBackgroundWithBlock {(data: NSData?, error: NSError?) -> Void in
                if let data = data {
                    //post.image is a reference to the PFFile; it has to be set to the actual image manually
                    let image = UIImage(data: data, scale: 1.0)!
                    
                    self.image.value = image
                }
            }
        }
    }
    
    func fetchLikes() {
        if likes.value != nil {
            return
        }
        
        ParseHelper.likesForPost(self, completionBlock: {(var likes: [AnyObject]?, error: NSError?) -> Void in
            likes = likes?.filter { like in
                //this goes through each like and removes the ones whose user's account has been deleted
                like[ParseHelper.ParseLikeFromUser] != nil
            }
            
            //this replaces the array of likes with an array of their users and sets self.likes.value to it
            self.likes.value = likes?.map { like in
                let like = like as! PFObject
                let fromUser = like[ParseHelper.ParseLikeFromUser] as! PFUser
                
                return fromUser
            }
        })
    }
    
    func doesUserLikePost(user: PFUser) -> Bool {
        if let likes = likes.value {
            return contains(likes, user)
        }
        else {
            return false
        }
    }
    
    func toggleLikePost(user: PFUser) {
        if doesUserLikePost(user) {
            likes.value = likes.value?.filter { $0 != user }
            ParseHelper.unlikePost(user, post: self)
        }
        else {
            likes.value?.append(user)
            ParseHelper.likePost(user, post: self)
        }
    }
    
}
