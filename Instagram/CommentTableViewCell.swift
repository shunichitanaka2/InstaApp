//
//  CommentTableViewCell.swift
//  Instagram
//
//  Created by 田中舜一 on 2016/08/19.
//  Copyright © 2016年 田中舜一. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentName: UILabel!
    @IBOutlet weak var commentTime: UILabel!
    @IBOutlet weak var commentText: UILabel!
    
    var commentData:CommentData!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        commentName.text = commentData.name
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP")
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.stringFromDate(commentData.date!)
        commentTime.text = dateString
        
        commentText.text = commentData.comment
        
        super.layoutSubviews()
    }
    
    
}
