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
    
    var post: Post!
    var request: Request?
//    var likeRef: FIRDatabaseReference!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }


    override func drawRect(rect: CGRect) {
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg.clipsToBounds = true

        showcaseImg.clipsToBounds = true
    }


    func configureCell(post: Post, img: UIImage?) {
        self.post = post
        
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
    }
}
