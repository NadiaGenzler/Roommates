//
//  NewEventViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 25/01/2020.
//  Copyright © 2020 NadiaGenzler. All rights reserved.
//

import UIKit

class EditEventViewController: UIViewController,UIPopoverPresentationControllerDelegate  {
    
    var firebase=FirebaseHelper.shared
    var util=Utilities.shared
    var formatter=DateFormatter()
    var senderIdentifier:String=""
    
    @IBOutlet weak var headerLable: UILabel!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var eventDesctiption: UITextView!
    var eventsProperties:[String:Any]=[:]
    
    var tapAccessibilityIdentifier:String = ""
    @IBAction func startDateTap(_ sender: UITapGestureRecognizer) {
        tapAccessibilityIdentifier="startDateTapped"
        chooseDate(sender)
    }
    @IBAction func endDateTap(_ sender: UITapGestureRecognizer) {
        tapAccessibilityIdentifier="endDateTapped"
        chooseDate(sender)
    }
    
//    MARK: Open DatePicker ViewController
    var popoverVC:DatePickerViewController?
    func chooseDate(_ sender: UITapGestureRecognizer) {
        popoverVC=storyboard?.instantiateViewController(withIdentifier: "datePicker") as? DatePickerViewController
        
        guard let popoverVC=popoverVC else {return}
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize=CGSize(width: 310, height: 235)
        if let popoverController=popoverVC.popoverPresentationController{
            popoverController.sourceView=sender.view
            popoverController.permittedArrowDirections = .up
            popoverController.delegate=self
            popoverVC.delegate = self
        }
        
        present(popoverVC,animated: true, completion: nil)
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

//    MARK:Save new or Update
    
    @IBAction func saveBtn(_ sender: UIButton) {
//      if the event  is new->addEvent to firbase

        if isEventNew(senderIdentifier){
            var newEvent=MyEvent(eventDescription: eventDesctiption.text ?? "no", startDate: formatter.date(from: startDate.text!) ?? Date(), endDate: formatter.date(from: endDate.text!) ?? Date(), tenantColor: UserDefaults.standard.string(forKey: "userColorString") ?? "#ffffff" ,eventKey:"")
            
            firebase.addEvent(apartmentKey: UserDefaults.standard.string(forKey: "apartmentKey")!, event: &newEvent)
            
        }
//      if the event exists->updateEvent to firebase
        else{
            var updatedEvent=MyEvent(eventDescription: eventDesctiption.text ?? "no", startDate: formatter.date(from: startDate.text!) ?? Date(), endDate: formatter.date(from: endDate.text!) ?? Date(), tenantColor: UserDefaults.standard.string(forKey: "userColorString") ?? "#ffffff", eventKey: eventsProperties["eventKey"] as! String)
            
            firebase.updateEvent(apartmentKey: UserDefaults.standard.string(forKey: "apartmentKey")!, eventKey: eventsProperties["eventKey"] as! String, event: &updatedEvent)
        }
        
        self.dismiss(animated: true)
    }
    
    func isEventNew(_ identifier:String)->Bool{
        if identifier=="EditExistingEvent"{
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat="MM/dd/yyyy HH:mm"
        self.view.backgroundColor=util.hexStringToUIColor(UserDefaults.standard.string(forKey: "userColorString") ?? "#ffffff")
        
        if isEventNew(senderIdentifier){
            headerLable.text="New Event"
            if senderIdentifier=="NewEventFromAddButton"{
                startDate.text=formatter.string(from: Date())
                endDate.text=formatter.string(from: Date())
            }else{
                startDate.text=formatter.string(from: eventsProperties["date"] as! Date)
                endDate.text=formatter.string(from: eventsProperties["date"] as! Date)
            }
            
        }else{
            headerLable.text="Edit Event"
            eventDesctiption.text=eventsProperties["eventDescription"] as! String
            startDate.text=formatter.string(from: eventsProperties["startDate"] as! Date)
            endDate.text=formatter.string(from: eventsProperties["endDate"] as! Date)
        }
    }
}
