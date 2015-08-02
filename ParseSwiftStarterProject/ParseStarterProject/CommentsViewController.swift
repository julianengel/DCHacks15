//
//  CommentsViewController.swift
//  Fire Feed
//
//  Created by Eric Kim on 8/2/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class CommentsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var post: Post!
    var comments: [Comment] = []
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let commentsQuery = PFQuery(className: "Comment")
        commentsQuery.whereKey("toPost", equalTo: post)
        commentsQuery.orderByDescending("createdAt")
        
        // 7
        commentsQuery.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            // 8
            self.comments = result as? [Comment] ?? []
            
            // 9
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CommentsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CommentCell") as! CommentTableViewCell
        
        cell.comment = comments[indexPath.row]
        cell.commentLabel.text = cell.comment?.text as! String
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
}
