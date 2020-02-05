//
//  Utilities.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 03/01/2020.
//  Copyright © 2020 NadiaGenzler. All rights reserved.
//

import UIKit

class Utilities {

    static var shared=Utilities()
    private init(){}
    
//    MARK: Color from String to UIColor
    func hexStringToUIColor (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    //    MARK: Show storyboards
    
    func showRegistrationStoryboard()->UIViewController{
        
        let registrationStoryBoard=UIStoryboard(name: "Registration", bundle: Bundle.main)
        let nav=registrationStoryBoard.instantiateViewController(withIdentifier: "registrationSb") as! UIViewController
           
        return nav
       
    }
    
    
    func showMainStoryboard()->UIViewController{
        let registrationStoryBoard=UIStoryboard(name: "Main", bundle: Bundle.main)
        let nav=registrationStoryBoard.instantiateViewController(withIdentifier: "mainStoryboard") as! UIViewController
     
            return nav
        }
    
}
