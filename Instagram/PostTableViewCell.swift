//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 田中舜一 on 2016/08/18.
//  Copyright © 2016年 田中舜一. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentTable: UITableView!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var commentButton: UIButton!
    
    
    var postData: PostData!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func layoutSubviews() {
        
        
        
        postImageView.image = postData.image
        captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP")
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.stringFromDate(postData.date!)
        dateLabel.text = dateString
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            likeButton.setImage(buttonImage, forState: UIControlState.Normal)
        }else{
            let buttonImage = UIImage(named: "like_none")
            likeButton.setImage(buttonImage, forState: UIControlState.Normal)
        }
        
        super.layoutSubviews()
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.comment.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as! CommentTableViewCell
        cell.commentData = postData.comment[indexPath.row]
        
        //cell.likeButton.addTarget(self, action: #selector(handleButton(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.layoutIfNeeded()
        
        return cell
    }
    
    
    
}
