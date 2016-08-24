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
    
    
    init(snapshot: FIRDataSnapshot) {
        LogTrace()
        id = snapshot.key
        guard let value = snapshot.value else {
            Log("value is nil")
            return
        }
        if let valueDirectory = snapshot.value as? [String: AnyObject] {
            name = valueDirectory["name"] as? String
            
            comment = valueDirectory["comment"] as? String
            
            if let time = valueDirectory["time"] as? NSTimeInterval {
                self.date = NSDate(timeIntervalSinceReferenceDate:time)
            }
        } else {
            Log("comment:"+value.debugDescription)
        }
        
    }
}