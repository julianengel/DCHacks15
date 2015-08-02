//
//  HomeViewController.swift
//  ParseStarterProject
//
//  Created by Julian Engel on 8/2/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse


let reuseIdentifier = "Cell"

class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!
    let postsQuery = PFQuery(className: "Post")

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
          var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        return cell
    }
    
        
    override func viewWillAppear(animated: Bool) {
    super.viewDidAppear(true)
        
        let postsFromFollowedUsers = PFQuery(className: "Post")
        postsFromFollowedUsers!.whereKey("user", matchesKey: "toUser", inQuery: followingQuery)
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}