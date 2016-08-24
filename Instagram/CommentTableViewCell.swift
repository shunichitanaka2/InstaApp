//
//  CommentTableViewCell.swift
//  Instagram
//
//  Created by 田中舜一 on 2016/08/19.
//  Copyright © 2016年 田中舜一. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentName: UILabel!
    @IBOutlet weak var commentTime: UILabel!
    @IBOutlet weak var commentText: UILabel!
    
    var commentData:CommentData!
    
    private var commentID:String?
    
    override func awakeFromNib() {
        LogTrace()
        super.awakeFromNib()
        // Initialization code
        
    }

    required init?(coder aDecoder: NSCoder) {
        LogTrace()
        super.init(coder: aDecoder)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        LogTrace()
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
    }
    
    func setData(commentID:String) {
        LogTrace()
        self.commentID = commentID
        FIRDatabase.database().reference().child(CommonConst.CommentPATH).observeEventType(.ChildAdded, withBlock: { snapshot in
            
            
            if (commentID == snapshot.key){
                
                let commentData = CommentData(snapshot: snapshot)
                Log("CommentName:"+commentData.name!)
                
                self.commentName.text = commentData.name
                
                let formatter = NSDateFormatter()
                formatter.locale = NSLocale(localeIdentifier: "ja_JP")
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                
                let dateString:String = formatter.stringFromDate(commentData.date!)
                self.commentTime.text = dateString
                self.commentText.text = commentData.comment
            }
        })
    }
}
