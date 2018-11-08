//
//  SpecialButton.swift
//  GymApp
//
//  Created by Eric Martin Gálan on 07/11/2018.
//  Copyright © 2018 Eric Martin Gálan. All rights reserved.
//

import UIKit

@IBDesignable
class SpecialButton: UIButton {

    @IBInspectable var buttonRadius : CGFloat = 0 {
        didSet{
            layer.cornerRadius = buttonRadius
            layer.masksToBounds = (buttonRadius > 0)
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet{
            layer.borderColor = borderColor?.cgColor
        }
    }
    

}
