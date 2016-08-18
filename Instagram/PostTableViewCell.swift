//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 田中舜一 on 2016/08/18.
//  Copyright © 2016年 田中舜一. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
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
            let buttonImage = UIImage(named: "like?_none")
            likeButton.setImage(buttonImage, forState: UIControlState.Normal)
        }
        
        super.layoutSubviews()
        
        
    }
    
    
    
}