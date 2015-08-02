//
//  Comment.swift
//  Fire Feed
//
//  Created by Eric Kim on 8/2/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import Parse

class Comment: PFObject, PFSubclassing {
    
    @NSManaged var toPost: Post?
    @NSManaged var voteCount: PFObject?
    @NSManaged var text: PFObject?
   
    static func parseClassName() -> String {
        return "Comment"
    }
    
    override init () {
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
}
