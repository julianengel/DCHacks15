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
    
    var post: Post?
    
    @IBAction func upvoteButtonTapped(sender: AnyObject) {
        if upvoteButton.selected {
            upvoteButton.selected = false
            voteCountLabel.text = "\((NSString(string: voteCountLabel.text!).intValue - 1))"
        }
        else if downvoteButton.selected{
            upvoteButton.selected = true
            downvoteButton.selected = false
            voteCountLabel.text = "\((NSString(string: voteCountLabel.text!).intValue + 2))"
        }
        else {
            upvoteButton.selected = true
            voteCountLabel.text = "\((NSString(string: voteCountLabel.text!).intValue + 1))"
        }
    }
    
    @IBAction func downvoteButtonTapped(sender: AnyObject) {
        if downvoteButton.selected {
            downvoteButton.selected = false
            voteCountLabel.text = "\((NSString(string: voteCountLabel.text!).intValue + 1))"
        }
        else if upvoteButton.selected{
            downvoteButton.selected = true
            upvoteButton.selected = false
            voteCountLabel.text = "\((NSString(string: voteCountLabel.text!).intValue - 2))"
        }
        else {
            downvoteButton.selected = true
            voteCountLabel.text = "\((NSString(string: voteCountLabel.text!).intValue - 1))"
        }
    }
    
    @IBAction func flagButtonTapped(sender: AnyObject) {
        flagButton.selected = !flagButton.selected
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
