//
//  HomeViewController.swift
//  Instagram
//
//  Created by 田中舜一 on 2016/08/17.
//  Copyright © 2016年 田中舜一. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postArray: [PostData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        
        FIRDatabase.database().reference().child(CommonConst.PostPATH).observeEventType(.ChildAdded, withBlock: { snapshot in
            
            // PostDataクラスを生成して受け取ったデータを設定する
            if let uid = FIRAuth.auth()?.currentUser?.uid {
                let postData = PostData(snapshot: snapshot, myId: uid)
                self.postArray.insert(postData, atIndex: 0)
                
                // TableViewを再表示する
                self.tableView.reloadData()
            }
        })
        
        // 要素が変更されたら該当のデータをpostArrayから一度削除した後に新しいデータを追加してTableViewを再表示する
        FIRDatabase.database().reference().child(CommonConst.PostPATH).observeEventType(.ChildChanged, withBlock: { snapshot in
            if let uid = FIRAuth.auth()?.currentUser?.uid {
                // PostDataクラスを生成して受け取ったデータを設定する
                let postData = PostData(snapshot: snapshot, myId: uid)
                
                // 保持している配列からidが同じものを探す
                var index: Int = 0
                for post in self.postArray {
                    if post.id == postData.id {
                        index = self.postArray.indexOf(post)!
                        break
                    }
                }
                
                // 差し替えるため一度削除する
                self.postArray.removeAtIndex(index)
                
                // 削除したところに更新済みのでデータを追加する
                self.postArray.insert(postData, atIndex: index)
                
                // TableViewの現在表示されているセルを更新する
                self.tableView.reloadData()
            }
        })
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as! PostTableViewCell
        cell.postData = postArray[indexPath.row]
        
        cell.likeButton.addTarget(self, action: #selector(handleButton(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //cell.commentButton.addTarget(self,action: #selector(commentButton(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.commentField.addTarget(self, action: #selector(commentUP(_:event:)), forControlEvents: UIControlEvents.EditingDidEndOnExit)
        
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // Auto Layoutを使ってセルの高さを動的に変更する
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // セルをタップされたら何もせずに選択状態を解除する
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func handleButton(sender: UIButton, event:UIEvent){
        
        let touch = event.allTouches()?.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        
        let postData = postArray[indexPath!.row]
        
        if let uid = FIRAuth.auth()?.currentUser?.uid{
            if postData.isLiked{
                var index = -1
                for likeId in postData.likes{
                    if likeId == uid{
                        index = postData.likes.indexOf(likeId)!
                        break
                    }
                }
                postData.likes.removeAtIndex(index)
                
            }else {
                postData.likes.append(uid)
            }
            
            let imageString = postData.imageString
            let name = postData.name
            let caption = postData.caption
            let time = (postData.date?.timeIntervalSinceReferenceDate)! as NSTimeInterval
            let likes = postData.likes
            
            let post = ["caption":caption!,"image": imageString!,"name": name!,"time":time,"likes":likes]
            let postRef = FIRDatabase.database().reference().child(CommonConst.PostPATH)
            postRef.child(postData.id!).setValue(post)
            
        }
    }
    
    
    func commentButton(sender: UIButton, event:UIEvent){
        let touch = event.allTouches()?.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        
        let postData = postArray[indexPath!.row]
        
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            
            
            let imageString = postData.imageString
            let name = postData.name
            let caption = postData.caption
            let time = (postData.date?.timeIntervalSinceReferenceDate)! as NSTimeInterval
            let likes = postData.likes
            let commentData = postData.comment
            
            
            
            // 辞書を作成してFirebaseに保存する
            let post = ["caption": caption!, "image": imageString!, "name": name!, "time": time, "likes": likes,"commentData": commentData]
            let postRef = FIRDatabase.database().reference().child(CommonConst.PostPATH)
            postRef.child(postData.id!).setValue(post)
        }
    }
    
    func commentUP(sender: UITextField, event:UIEvent){
        
        let text_field = sender
        
        let touched_PostData = text_field.superview?.superview as! PostTableViewCell
        
        let row = tableView.indexPathForCell(touched_PostData)?.row
        
        //let touch = event.allTouches()?.first
        //let point = touch!.locationInView(self.tableView)
        //let indexPath = tableView.indexPathForRowAtPoint(point)
        
        //let postData = postArray[indexPath!.row]
        let postData = postArray[row!]
        
        //let id = postData.id
        let imageString = postData.imageString
        let name = postData.name
        let caption = postData.caption
        let time = (postData.date?.timeIntervalSinceReferenceDate)! as NSTimeInterval
        let likes = postData.likes
        //let commentData = postData.comment
            
        //let commentData = CommentData(snapshot: sender.text, myId: uid)
        
        let ud = NSUserDefaults.standardUserDefaults()
        let comment_name = ud.objectForKey(CommonConst.DisplayNameKey) as? String ?? ""
        let comment_time = NSDate.timeIntervalSinceReferenceDate()
        
        let commentData = CommentData(get_id: "tentative_value",get_name: comment_name ,get_comment: sender.text! ,get_date:comment_time)
        
        var commentArray: [CommentData] = postData.comment
        
        commentArray.append(commentData)
            
            
        // 辞書を作成してFirebaseに保存する
        let post = ["caption": caption!, "image": imageString!, "name": name!, "time": time, "likes": likes,"commentData": commentArray]
        let postRef = FIRDatabase.database().reference().child(CommonConst.PostPATH)
        postRef.child(postData.id!).setValue(post)
    }
    
    
    
}
