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
    let formatter=DateFormatter()
    var dateTapped:String=""
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        let date:Date = sender.date
        
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
        
        formatter.dateFormat="MM/dd/yyyy HH:mm"
        dateTapped=delegate?.tapAccessibilityIdentifier ?? ""
        
        if dateTapped == "startDateTapped" {
            datePicker.setDate(formatter.date(from: delegate?.startDate.text ?? "" ) ?? Date(), animated: true)
        }else{
            datePicker.setDate(formatter.date(from: delegate?.endDate.text ?? "" ) ?? Date(), animated: true)
            
        }
    }
    
    
    
    
}
