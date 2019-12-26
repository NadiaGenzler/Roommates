//
//  GradientView.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 16/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {

    override class var layerClass: AnyClass{
        get{
            return CAGradientLayer.self
        }
    }
    
    @IBInspectable var firstColor:UIColor=UIColor.red{
        didSet{
            commonInit()
        }
    }
    
    @IBInspectable var secondColor:UIColor=UIColor.white{
        didSet{
            commonInit()
        }
    }
    
    @IBInspectable var startPoint:CGPoint=CGPoint(x: 0, y:  0){
           didSet{
               commonInit()
           }
       }
       
    @IBInspectable var endPoint:CGPoint=CGPoint(x: 1, y:  1){
           didSet{
               commonInit()
           }
       }
       
    
    func commonInit(){
        guard let layer=self.layer as? CAGradientLayer else {return}
        
        layer.colors=[firstColor.cgColor,secondColor.cgColor]
        layer.startPoint=self.startPoint
        layer.endPoint=self.endPoint
    }
    
    
}
