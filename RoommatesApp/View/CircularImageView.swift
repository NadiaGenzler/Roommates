//
//  CircularImageView.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 23/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit


@IBDesignable
public class CircularImageView: UIImageView {
   
    
//    lazy var imageLayer: CALayer = {
//        let imageLayer = CALayer()
//
//        let bundle = Bundle(for: CircularImageView.self)
//        imageLayer.contents = UIImage(named: "user_male", in: bundle, compatibleWith: nil)?.cgImage
//        imageLayer.masksToBounds = true //cut to the radius
//        return imageLayer
//    }()
    
   @IBInspectable var borderRadius:Double = 1.0{
       didSet{
           self.layer.cornerRadius = CGFloat(borderRadius)
       }
   }

   @IBInspectable var borderWidth:Double = 1.0{
        didSet{
            self.layer.borderWidth = CGFloat(borderWidth)
        }
    }

   @IBInspectable var borderColor:UIColor = UIColor.black{
        didSet{
           self.layer.borderColor = borderColor.cgColor
        }
    }

   @IBInspectable var circle:Bool = false{
        didSet{
           if circle{
               self.layer.cornerRadius = bounds.height / 2
           }
        }
    }
    
//    public override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        commonInit()
//    }
//    
//    
//    public override func awakeFromNib() {
//        super.awakeFromNib()
//        commonInit()
//    }
    
//    func commonInit(){
//       let bundle = Bundle(for: CircularImageView.self)
//       image = UIImage(named: "user_male", in: bundle, compatibleWith: nil)?.cgImage
//      //  imageLayer.frame = self.bounds
//        layer.addSublayer(imageLayer)
//       
//    }
}

