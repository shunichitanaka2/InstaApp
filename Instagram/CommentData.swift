//
//  CommentData.swift
//  Instagram
//
//  Created by 田中舜一 on 2016/08/19.
//  Copyright © 2016年 田中舜一. All rights reserved.
//


import UIKit
import Firebase
import FirebaseDatabase


class CommentData: NSObject {
    var id: String?
    var name:String?
    var comment:String?
    var date:NSDate?
    
    
    init(get_id: String,get_name:String,get_comment:String,get_date:NSTimeInterval) {
        id = get_id
        
        name = get_name
        
        comment = get_comment
        
        self.date = NSDate(timeIntervalSinceReferenceDate: get_date)
    }
    
}