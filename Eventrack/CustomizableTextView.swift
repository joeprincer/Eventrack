//
//  CustomizableTextView.swift
//  Eventrack
//
//  Created by Jiazhou Liu on 22/5/17.
//  Copyright © 2017 Jiazhou Liu. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableTextView: UITextView {
    
    // add cornerRadius attribute for UITextView
    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    // add cornerRadius attribute for UITextView
    @IBInspectable var borderWidth: CGFloat = 0 {
        
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    
}
