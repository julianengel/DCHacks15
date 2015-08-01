//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Eric Kim on 6/29/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Bond
import Parse

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesIconImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    var likeBond: Bond<[PFUser]?>!
    
    var post: Post? {
        didSet {
            if let post = post {
                //whenever post.image changes, update postImageView accordingly
                post.image ->> postImageView
                
                //post.likes is a Dynamic optional array of PFUsers
                post.likes ->> likeBond
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        likeBond = Bond<[PFUser]?>() { [unowned self] likeList in
            if let likeList = likeList {
                self.likesLabel.text = self.stringFromUserList(likeList)
                self.likeButton.selected = contains(likeList, PFUser.currentUser()!)
                self.likesIconImageView.hidden = (likeList.count == 0)
            }
            // this case happens if there is no list of users who liked the post
            else {
                self.likesLabel.text = ""
                self.likeButton.selected = false
                self.likesIconImageView.hidden = true
            }
        }
    }
    
    func stringFromUserList(userList: [PFUser]) -> String {
        let usernameList = userList.map { user in
            user.username!
        }
        let commaSeparatedUserList = ", ".join(usernameList)
        
        return commaSeparatedUserList
    }
    
    @IBAction func moreButtonTapped(sender: AnyObject) {
        
    }
    
    @IBAction func likeButtonTapped(sender: AnyObject) {
        post?.toggleLikePost(PFUser.currentUser()!)
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
