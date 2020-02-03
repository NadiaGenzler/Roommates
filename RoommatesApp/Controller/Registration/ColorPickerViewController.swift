//
//  ColorPickerViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 29/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var tag:Int=0
    var cellColor:UIColor=UIColor.gray
    var colors=["#ffccff","#FDDFDF","#FCF7DE","#F0DEFD","#DEF3FD","#DEFDE0","#d1edf2","#ffd8a7"]
    var delegate : JoiningViewController? = nil
    var utilities=Utilities.shared
    
    
    
      func numberOfSections(in collectionView: UICollectionView) -> Int {
     
           return 1
       }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
           return 8
       }
   
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
        view.backgroundColor=UIColor.darkGray
        cellColor=utilities.hexStringToUIColor(colors[indexPath.item])
        cell.contentView.backgroundColor=cellColor
        
        cell.tag = tag
        tag = tag + 1
        
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let cell: UICollectionViewCell  = collectionView.cellForItem(at: indexPath)! as UICollectionViewCell
        
        let sColor=colors[cell.tag]
        cellColor=utilities.hexStringToUIColor(sColor)
        delegate?.colorView.backgroundColor=cellColor
        delegate?.stringColor=sColor
        delegate?.popoverVC?.dismiss(animated: true)
        
        
    }
      

}


