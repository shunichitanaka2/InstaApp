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
    
    
    init(snapshot: FIRDataSnapshot,myId:String) {
        id = snapshot.key
        
        let valueDirectory = snapshot.value as! [String: AnyObject]
        
        name = valueDirectory["name"] as? String
        
        comment = valueDirectory["comment"] as? String
        
        self.date = NSDate(timeIntervalSinceReferenceDate: valueDirectory["time"] as! NSTimeInterval)
    }
    
}