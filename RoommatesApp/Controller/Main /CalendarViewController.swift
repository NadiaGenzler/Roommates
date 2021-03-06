//
//  CalendarViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 11/01/2020.
//  Copyright © 2020 NadiaGenzler. All rights reserved.
//

import UIKit
import CalendarKit

class CalendarViewController: DayViewController {
    
    var firebase=FirebaseHelper.shared
    var util=Utilities.shared
    var formatter=DateFormatter()
    var eventsArr:[MyEvent]?
    
    @IBAction func openMenu(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name("openMenu"), object: nil)
    }
    
    @IBAction func addEvent(_ sender: UIBarButtonItem) {
        eventPopover(sender,[:])
        reloadData()
    }
    
    func eventPopover(_ sender : Any,_ eventProperties:[String:Any]){
        
        let popoverVC=storyboard?.instantiateViewController(identifier: "EventEditor") as! EditEventViewController
        popoverVC.modalPresentationStyle = .automatic
        popoverVC.eventsProperties=eventProperties
        // chek how the sender in order to know what dates and event to display on the edit event controller
        if sender is UIBarButtonItem{
            popoverVC.senderIdentifier="NewEventFromAddButton"
        }else if sender is UILongPressGestureRecognizer{
            popoverVC.senderIdentifier="NewEventFromLongPress"
        }else{
            popoverVC.senderIdentifier="EditExistingEvent"
        }
        
        present(popoverVC, animated: true)
    }
    
//    MARK: Fetch the events from firebase
    override func viewDidLoad() {
        super.viewDidLoad()
        let apartmentKey = UserDefaults.standard.string(forKey: "apartmentKey")
        firebase.fetchEventData(apartmentKey: apartmentKey!) { (events) in
            
            self.eventsArr=events
            self.reloadData()
        }
        dayView.autoScrollToFirstEvent = true
    }
    
    // MARK: EventDataSource
    
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        var events = [Event]()
        
        if let myEvents=eventsArr{
            for myevent in myEvents {
                
                let event = Event()
                
                event.text=myevent.eventDescription
                event.startDate = myevent.startDate
                event.endDate = myevent.endDate
                event.backgroundColor=util.hexStringToUIColor(myevent.tenantColor)
                
                //event.isAllDay=true
                event.userInfo=["eventKey" : myevent.eventKey, "eventDescription":myevent.eventDescription, "startDate":myevent.startDate, "endDate":myevent.endDate] as? [String:Any]
                events.append(event)
            }
        }
        
        return events
    }
    
    
    
    // MARK: DayViewDelegate
    
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let descriptor = eventView.descriptor as? Event else {return}
        eventPopover(UITapGestureRecognizer(),descriptor.userInfo as! [String:Any])
    }
    
    override func dayView(dayView: DayView, didLongPressTimelineAt date: Date) {
        eventPopover(UILongPressGestureRecognizer(), ["date":date])
    }
    
    override func dayViewDidLongPressEventView(_ eventView: EventView) {
        guard let descriptor = eventView.descriptor as? Event else {return}
        let eventProperties=descriptor.userInfo as! [String:Any]
        
        let alert=UIAlertController(title: "Are you sure you want to delete?", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            self.firebase.removeEvent(apartmentKey: UserDefaults.standard.string(forKey: "apartmentKey")!, eventKey: eventProperties["eventKey"] as! String)
        })
        
        alert.addAction(okAction)
        alert.addAction(.init(title: "Cancel", style: .default, handler: { (action) in
            alert.dismiss(animated: true)
        }))
        
        present(alert, animated: true)
        
    }
    
}
