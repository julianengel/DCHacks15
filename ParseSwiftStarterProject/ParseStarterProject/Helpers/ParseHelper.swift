//
//  ParseHelper.swift
//  Makestagram
//
//  Created by Eric Kim on 6/29/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import Parse

class ParseHelper {
    
    // Following Relation
    static let ParseFollowClass       = "Follow"
    static let ParseFollowFromUser    = "fromUser"
    static let ParseFollowToUser      = "toUser"
    
    // Like Relation
    static let ParseLikeClass         = "Like"
    static let ParseLikeToPost        = "toPost"
    static let ParseLikeFromUser      = "fromUser"
    
    // Post Relation
    static let ParsePostUser          = "user"
    static let ParsePostCreatedAt     = "createdAt"
    
    // Flagged Content Relation
    static let ParseFlaggedContentClass    = "FlaggedContent"
    static let ParseFlaggedContentFromUser = "fromUser"
    static let ParseFlaggedContentToPost   = "toPost"
    
    // User Relation
    static let ParseUserUsername      = "username"
    
    //completionBlock is the callback block to be called once querying is complete
    static func timelineRequestForCurrentUser(range: Range<Int>, completionBlock: PFArrayResultBlock) {
        let followingQuery = PFQuery(className: ParseFollowClass)
        followingQuery.whereKey(ParseFollowFromUser, equalTo: PFUser.currentUser()!)
        
        let postsFromFollowedUsers = Post.query()
        postsFromFollowedUsers!.whereKey(ParsePostUser, matchesKey: ParseFollowToUser, inQuery: followingQuery)
        
        let postsFromThisUser = Post.query()
        postsFromThisUser!.whereKey(ParsePostUser, equalTo: PFUser.currentUser()!)
        
        //this makes the union of the two queries
        let query = PFQuery.orQueryWithSubqueries([postsFromFollowedUsers!, postsFromThisUser!])
        
        //this stores the posts' users' information so that the username can be accessed later. without it, we would have just references to the users
        query.includeKey(ParsePostUser)
        query.orderByDescending(ParsePostCreatedAt)
        
        //the query needs to start at the startIndex, i.e. skip everything before it
        query.skip = range.startIndex
        query.limit = range.endIndex - range.startIndex
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    //MARK: Likes
    
    static func likePost(user: PFUser, post: Post) {
        let likeObject = PFObject(className: ParseLikeClass)
        likeObject[ParseLikeFromUser] = user
        likeObject[ParseLikeToPost] = post
        
        likeObject.saveInBackgroundWithBlock(nil)
    }
    
    static func unlikePost(user: PFUser, post: Post) {
        let query = PFQuery(className: ParseLikeClass)
        query.whereKey(ParseLikeFromUser, equalTo: user)
        query.whereKey(ParseLikeToPost, equalTo: post)
        
        query.findObjectsInBackgroundWithBlock {(results: [AnyObject]?, error: NSError?) -> Void in
            if let results = results as? [PFObject] {
                for likes in results {
                    likes.deleteInBackgroundWithBlock(nil)
                }
            }
        }
    }
    
    static func likesForPost(post: Post, completionBlock: PFArrayResultBlock) {
        let query = PFQuery(className: ParseLikeClass)
        query.whereKey(ParseLikeToPost, equalTo: post)
        query.includeKey(ParseLikeFromUser)
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    //MARK: Following
    
    //this finds everyone the user is following
    static func getFollowingUsersForUser(user: PFUser, completionBlock: PFArrayResultBlock) {
        let query = PFQuery(className: ParseFollowClass)
        
        query.whereKey(ParseFollowFromUser, equalTo: user)
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    static func addFollowRelationshipFromUser(user: PFUser, toUser: PFUser) {
        let followObject = PFObject(className: ParseFollowClass)
        followObject.setObject(user, forKey: ParseFollowFromUser)
        followObject.setObject(toUser, forKey: ParseFollowToUser)
        
        followObject.saveInBackgroundWithBlock(nil)
    }
    
    static func removeFollowRelationshipFromUser(user: PFUser, toUser: PFUser) {
        var query = PFQuery(className: ParseFollowClass)
        query.whereKey(ParseFollowFromUser, equalTo: user)
        query.whereKey(ParseFollowToUser, equalTo: toUser)
        
        query.findObjectsInBackgroundWithBlock {(results: [AnyObject]?, error: NSError?) -> Void in
            let results = results as? [PFObject] ?? []
            
            for follow in results {
                follow.deleteInBackgroundWithBlock(nil)
            }
        }
    }
    
    //this finds and returns the query for up to 20 other users
    static func allUsers(completionBlock: PFArrayResultBlock) -> PFQuery {
        let query = PFUser.query()!
        query.whereKey(ParseUserUsername, notEqualTo: PFUser.currentUser()!.username!)
        query.orderByAscending(ParseUserUsername)
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
        return query
    }
    
    //this finds and returns the query for up to 20 users whose usernames match the search term
    static func searchUsers(searchText: String, completionBlock: PFArrayResultBlock) -> PFQuery {
        //this method uses regex for case insensitivity
        let query = PFUser.query()!.whereKey(ParseUserUsername, matchesRegex: searchText, modifiers: "i")
        
        query.whereKey(ParseUserUsername, notEqualTo: PFUser.currentUser()!.username!)
        
        query.orderByAscending(ParseUserUsername)
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
        return query
    }
    
    //the last 2 methods return queries to have them cancelled when a new char is typed into the search bar
}

extension PFObject: Equatable {
    
}

public func ==(lhs: PFObject, rhs: PFObject) -> Bool {
    return lhs.objectId == rhs.objectId
}
