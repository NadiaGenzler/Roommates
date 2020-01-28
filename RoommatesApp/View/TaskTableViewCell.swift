//
//  TaskTableViewCell.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 23/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {


    @IBOutlet weak var chekmark: UIImageView!
    
    @IBOutlet weak var delete: UIImageView!
    @IBOutlet weak var update: UIImageView!
    
    @IBOutlet weak var taskText: UILabel!
    var tasksProperties:[String:Any]=[:]
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
