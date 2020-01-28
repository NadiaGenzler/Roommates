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
//    var dateFormatter=DateFormatter()
    
//    func presentPopover(popoverVC: inout UIViewController,identifier: String, popoverSize : CGSize) {
//        popoverVC=popoverVC.storyboard?.instantiateViewController(withIdentifier: identifier) ?? <#default value#>
//           
//           guard let popoverVC=popoverVC else {return}
//           popoverVC.modalPresentationStyle = .popover
//           popoverVC.preferredContentSize=popoverSize
//           if let popoverController=popoverVC.popoverPresentationController{
//               popoverController.sourceView=sender.view
//               popoverController.permittedArrowDirections = .up
//               popoverController.delegate=self
//               popoverVC.delegate = self
//           }
//           
//           present(popoverVC,animated: true, completion: nil)
//           
//       }
}
