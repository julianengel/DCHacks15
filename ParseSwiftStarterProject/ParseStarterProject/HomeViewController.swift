//
//  HomeViewController.swift
//  ParseStarterProject
//
//  Created by Julian Engel on 8/2/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    let reuseIdentifier = "cell"
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = "HELLO PARSE"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return 4
    }
}
