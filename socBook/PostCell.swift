//
//  PostCell.swift
//  socBook
//
//  Created by Alan Glasby on 19/07/2016.
//  Copyright © 2016 Alan Glasby. All rights reserved.
//

import UIKit
import Firebase
import Alamofire


class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var showcaseImg: UIImageView!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likesImage: UIImageView!
    
    var post: Post!
    var request: Request?
    var likeRef: FIRDatabaseReference!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PostCell.likeTapped(_:)))
        tap.numberOfTapsRequired = 1
        likesImage.addGestureRecognizer(tap)
        likesImage.userInteractionEnabled = true
        
    }


    override func drawRect(rect: CGRect) {
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg.clipsToBounds = true

        showcaseImg.clipsToBounds = true
    }


    func configureCell(post: Post, img: UIImage?) {
        self.showcaseImg.image = nil
        self.post = post
        self.likeRef = DataService.ds.REF_USER_CURRENT.child("likes").child(post.postKey)
        
        self.descriptionTxt.text = post.postDescription
        self.likesLbl.text = "\(post.likes)"
        
        if post.imgUrl != nil {
            if img != nil {
                self.showcaseImg.image = img
            } else {
                
                request = Alamofire.request(.GET, post.imgUrl!).validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, err in
                    if err == nil {
                        if let img = UIImage(data: data!) {
                            self.showcaseImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: self.post.imgUrl!)
                        }
                    }
                })
            }
        } else {
            self.showcaseImg.image = nil
        }
        
        likeRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let doesNotExist = snapshot.value as? NSNull {
//                No like for this specific post
                self.likesImage.image = UIImage(named: "heart-empty")
            } else {
                self.likesImage.image = UIImage(named: "heart-full")
            }
        })
        
        
    }
    
    func likeTapped(sender: UITapGestureRecognizer) {
        likeRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let doesNotExist = snapshot.value as? NSNull {
                //                Already liked this specific post
                self.likesImage.image = UIImage(named: "heart-full")
                self.post.adjustLikes(true)
                self.likeRef.setValue(true)
            } else {
                self.likesImage.image = UIImage(named: "heart-empty")
                self.post.adjustLikes(false)
                self.likeRef.removeValue()
            }
        })
    }
    

}
