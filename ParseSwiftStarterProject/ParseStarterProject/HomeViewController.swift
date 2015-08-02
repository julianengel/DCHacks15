//
//  HomeViewController.swift
//  ParseStarterProject
//
//  Created by Julian Engel on 8/2/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var hiddenButton: UIButton!
    @IBOutlet weak var tableView : UITableView!
    
    var posts: [Post] = []
    var selectedIndex: Int!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = self.tableView.dequeueReusableCellWithIdentifier("PostCell") as! TimelineTableViewCell
        
        cell.post = posts[indexPath.row]
        cell.tableViewCellImage.image = cell.post!.image
        if let caption = cell.post!["caption"] as? String {
            cell.captionLabel.text = caption
        }
        
        var comments: [Comment] = []
        
        let commentsQuery = PFQuery(className: "Comment")
        commentsQuery.whereKey("toPost", equalTo: cell.post!)
        commentsQuery.orderByDescending("createdAt")
        
        // 7
        commentsQuery.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            // 8
            comments = result as? [Comment] ?? []
            
            cell.commentsButton.setTitle("\(comments.count) Comments", forState: UIControlState.Normal)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row
    }
    
        
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        PFUser.logInWithUsername("tested", password: "tested")
        
        let postsQuery = PFQuery(className: "Post")
        postsQuery.whereKey("user", equalTo: PFUser.currentUser()!)
        
        postsQuery.orderByDescending("createdAt")
        
        // 7
        postsQuery.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            // 8
            self.posts = result as? [Post] ?? []
            
            for post in self.posts {
                let data = post.imageFile?.getData()
                post.image = UIImage(data: data!, scale: 1.0)
            }
            
            // 9
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        var currentUser = PFUser.currentUser()
//        if currentUser != nil {
//            // Do stuff with the user
//        } else {
//            PFUser.logInWithUsernameInBackground("abcde", password:"onetwothree") {
//                (user: PFUser?, error: NSError?) -> Void in
//                if user != nil {
//                    // Do stuff after successful login.
//                    PFUser.logInWithUsernameInBackground("abcde", password:"onetwothree") {
//                        (user: PFUser?, error: NSError?) -> Void in
//                        if user != nil {
//                            // Do stuff after successful login.
//                        } else {
//                            // The login failed. Check error to see why.
//                        }
//                    }
//                    
//                    
//                } else {
//                    // The login failed. Check error to see why.
//                    var user = PFUser()
//                    user.username = "abcde"
//                    user.password = "onetwothree"
//                    user.email = "email@example.com"
//                    // other fields can be set just like with PFObject
//                    user["phone"] = "415-392-0202"
//                    
//                    
//                    
//                    user.signUpInBackgroundWithBlock {
//                        (succeeded: Bool, error: NSError?) -> Void in
//                        if let error = error {
//                            let errorString = error.userInfo?["error"] as? NSString
//                            // Show the errorString somewhere and let the user try again.
//                            println("\n \(error) \n")
//                        } else {
//                            // Hooray! Let them use the app now.
//                        }
//                    }
//                    
//                }
//            }
//        }
//        
//        
//        
//        
//        
        
//        var timer = NSTimer()
//        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("FUNCTION"), userInfo: nil, repeats: true)
        
        self.tableView.registerClass(TimelineTableViewCell.self, forCellReuseIdentifier: "PostCell")
    }
    
    func unwindToSegue(segue: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "ShowComments" {
                let commentsViewController = segue.destinationViewController as! CommentsViewController
                
                commentsViewController.post = posts[selectedIndex]
            }
        }
    }
}