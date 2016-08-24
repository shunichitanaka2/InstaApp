//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 田中舜一 on 2016/08/18.
//  Copyright © 2016年 田中舜一. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


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
        commentTable.delegate = self
        commentTable.dataSource = self
        
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        commentTable.registerNib(nib, forCellReuseIdentifier: "CommentTableViewCell")
        commentTable.rowHeight = UITableViewAutomaticDimension
    }
    
    required init?(coder aDecoder: NSCoder) {
        LogTrace()
        super.init(coder: aDecoder)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func layoutSubviews() {
        LogTrace()
        super.layoutSubviews()
        
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
        
        self.commentTable.reloadData()
        
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        LogTrace()
        // Auto Layoutを使ってセルの高さを動的に変更する
        //return 70
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        LogTrace()
        Log(postData.commentIDArray.count.description)
        return postData.commentIDArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        LogTrace()
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentTableViewCell",forIndexPath: indexPath) as! CommentTableViewCell
        cell.setData(postData.commentIDArray[indexPath.row])
        cell.layoutIfNeeded()
        return cell
    }
    
    
    func getHeight() -> CGFloat {
        LogTrace()
        return 1000 + CGFloat((self.postData.commentIDArray.count * 100))
    }
}
