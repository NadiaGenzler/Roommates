//
//  roundView.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

@IBDesignable class RoundView: UIView {
    
    @IBInspectable var borderRadius:CGFloat=10{
        didSet{
            layer.cornerRadius=self.borderRadius
            clipsToBounds=true
        }
    }
    @IBInspectable var viewBackgroundColor:UIColor = .clear{
        didSet{
            layer.backgroundColor=self.viewBackgroundColor.cgColor
            
        }
    }
    
    @IBInspectable var circle:Bool = false{
        didSet{
            if circle{
                self.layer.cornerRadius = bounds.height / 2
            }
        }
    }
    
    
}
