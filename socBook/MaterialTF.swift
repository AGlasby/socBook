//
//  MaterialTF.swift
//  socBook
//
//  Created by Alan Glasby on 16/07/2016.
//  Copyright © 2016 Alan Glasby. All rights reserved.
//

import UIKit

class MaterialTF: UITextField {

    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderColor = UIColor(red: SHADOW_COLOUR, green: SHADOW_COLOUR, blue: SHADOW_COLOUR, alpha: 0.1).CGColor
        layer.borderWidth = 1.0

    }

//    For Placeholder text

    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }

//    For editable text
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }

}
