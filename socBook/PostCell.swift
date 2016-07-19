//
//  PostCell.swift
//  socBook
//
//  Created by Alan Glasby on 19/07/2016.
//  Copyright © 2016 Alan Glasby. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var showcaseImg: UIImageView!
    
//    var post: Post!
//    var request: Request?
//    var likeRef: FIRDatabaseReference!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }


    override func drawRect(rect: CGRect) {
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg.clipsToBounds = true

        showcaseImg.clipsToBounds = true
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
