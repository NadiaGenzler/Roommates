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
    var colors=["#ffccff","#ff99bb","#e184c2","#d9b3ff","#b3d9ff","#99ffff","#b3ffe6","#ffbb99"]
    var delegate : JoiningViewController? = nil
    var utilities=Utilities.shared
    
    
    
      func numberOfSections(in collectionView: UICollectionView) -> Int {
           // #warning Incomplete implementation, return the number of sections
           return 1
       }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of items
           return 8
       }
   
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
        cellColor=utilities.hexStringToUIColor(colors[indexPath.item])
        print(cellColor)
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


