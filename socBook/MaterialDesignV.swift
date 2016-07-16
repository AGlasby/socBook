//
//  MaterialDesignV.swift
//  socBook
//
//  Created by Alan Glasby on 16/07/2016.
//  Copyright © 2016 Alan Glasby. All rights reserved.
//

import UIKit

class MaterialDesignV: UIView {

    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red: SHADOW_COLOUR, green: SHADOW_COLOUR, blue: SHADOW_COLOUR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.00, 2.00)
        
    }

}
