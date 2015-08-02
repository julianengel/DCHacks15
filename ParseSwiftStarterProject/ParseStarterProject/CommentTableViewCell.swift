//
//  CommentTableViewCell.swift
//  Fire Feed
//
//  Created by Eric Kim on 8/2/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var upvoteButton: UIButton!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var downvoteButton: UIButton!
    
    var comment: Comment?
    
    @IBAction func upvoteButtonTapped(sender: AnyObject) {
        if upvoteButton.selected {
            upvoteButton.selected = false
            comment?.voteCount!.decreaseSize(nil)
            voteCountLabel.text = "\(comment?.voteCount!)"
        }
        else if downvoteButton.selected{
            upvoteButton.selected = true
            downvoteButton.selected = false
            comment?.voteCount!.increaseSize(nil)
            comment?.voteCount!.increaseSize(nil)
            voteCountLabel.text = "\(comment?.voteCount!)"
        }
        else {
            upvoteButton.selected = true
            comment?.voteCount!.increaseSize(nil)
            voteCountLabel.text = "\(comment?.voteCount!)"
        }
    }
    
    @IBAction func downvoteButtonTapped(sender: AnyObject) {
        if downvoteButton.selected {
            downvoteButton.selected = false
            comment?.voteCount!.increaseSize(nil)
            voteCountLabel.text = "\(comment?.voteCount!)"
        }
        else if upvoteButton.selected{
            downvoteButton.selected = true
            upvoteButton.selected = false
            comment?.voteCount!.decreaseSize(nil)
            comment?.voteCount!.decreaseSize(nil)
            voteCountLabel.text = "\(comment?.voteCount!)"
        }
        else {
            downvoteButton.selected = true
            comment?.voteCount!.decreaseSize(nil)
            voteCountLabel.text = "\(comment?.voteCount!)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
