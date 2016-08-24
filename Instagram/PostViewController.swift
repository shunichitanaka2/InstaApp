//
//  PostViewController.swift
//  Instagram
//
//  Created by 田中舜一 on 2016/08/17.
//  Copyright © 2016年 田中舜一. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class PostViewController: UIViewController {
    
    var image: UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func handlePostButton(sender: AnyObject) {
        
        let postRef = FIRDatabase.database().reference().child(CommonConst.PostPATH)
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.5)
        
        // NSUserDfaultsから表示名を取得する
        let ud = NSUserDefaults.standardUserDefaults()
        
        let name = ud.objectForKey(CommonConst.DisplayNameKey) as? String ?? ""
        let time = NSDate.timeIntervalSinceReferenceDate()
        
        let commentArray: [CommentData] = []
        
        let postData = ["caption": textField.text!,"image":imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength),"name":name,"time":time,"comment":commentArray]
        postRef.childByAutoId().setValue(postData)
        
        SVProgressHUD.showSuccessWithStatus("投稿しました")
        
        UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func handleCancelButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
