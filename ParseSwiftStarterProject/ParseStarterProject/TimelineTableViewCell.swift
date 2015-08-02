//
//  TimelineTableViewCell.swift
//  ParseStarterProject
//
//  Created by Eric Kim on 8/2/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var upvoteButton: UIButton!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var downvoteButton: UIButton!
    @IBOutlet weak var flagButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var tableViewCellImage: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: Post!
    
    @IBAction func upvoteButtonTapped(sender: AnyObject) {
        
    }
    
    @IBAction func downvoteButtonTapped(sender: AnyObject) {
        
    }
    
    @IBAction func flagButtonTapped(sender: AnyObject) {
        
    }
    
    @IBAction func commentsButtonTapped(sender: AnyObject) {
        
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        tableViewCellImage = UIImageView(image: post.image)
//        if let caption = post["caption"] as? String {
//            captionLabel.text = caption
//        }
//    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
