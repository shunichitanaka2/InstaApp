//
//  PostData.swift
//  Instagram
//
//  Created by 田中舜一 on 2016/08/18.
//  Copyright © 2016年 田中舜一. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class PostData: NSObject {
    var id: String?
    var image:UIImage?
    var imageString:String?
    var name:String?
    var caption:String?
    var date:NSDate?
    var likes:[String] = []
    var isLiked: Bool = false
    
    init(snapshot: FIRDataSnapshot,myId:String) {
        id = snapshot.key
        
        let valueDirectory = snapshot.value as! [String: AnyObject]
        
        imageString = valueDirectory["image"] as? String
        image = UIImage(data: NSData(base64EncodedString: imageString!, options: .IgnoreUnknownCharacters)!)
        
        name = valueDirectory["name"] as? String
        
        caption = valueDirectory["caption"] as? String
        
        if let likes = valueDirectory["likes"] as? [String]{
            self.likes = likes
        }
        
        for likeId in likes {
            if likeId == myId {
                isLiked = true
                break
            }
        }
        
        self.date = NSDate(timeIntervalSinceReferenceDate: valueDirectory["time"] as! NSTimeInterval)
    }
    
    
    
    
    
}