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
    
    @IBOutlet weak var tableView : UITableView!
    var posts: [Post] = []

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = self.tableView.dequeueReusableCellWithIdentifier("PostCell") as! TimelineTableViewCell
        
        cell.post = posts[indexPath.row]
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
        
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let postsQuery = PFQuery(className: "Post")
        
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

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}