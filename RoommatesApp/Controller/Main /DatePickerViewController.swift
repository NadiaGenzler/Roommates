//
//  DatePickerViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 26/01/2020.
//  Copyright © 2020 NadiaGenzler. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    var delegate:EditEventViewController?
    
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        let date:Date = sender.date
        let formatter=DateFormatter()
        formatter.dateFormat="MM/dd/yyyy HH:mm"
     
        let dateTapped=delegate?.tapAccessibilityIdentifier
        
        if dateTapped == "startDateTapped" {
            delegate?.startDate.text=formatter.string(from: date)
        }else{
            delegate?.endDate.text=formatter.string(from: date)
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
}
