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
    //1/add new event by pressing tne + sighn and by longpress on thr time line
    //2/edit event by long press on the existing event  -  both with the same view

    //5/resolve the issue with the hours showing one hour early
    //6/edit the landscape layout
    //7/
    
   
    var firebase=FirebaseHelper.shared
    var util=Utilities.shared
    
    var eventsArr:[MyEvent]?
    
    @IBAction func addEvent(_ sender: UIBarButtonItem) {
//        eventPopover(sender)
//        var event=MyEvent(eventName: "go2", eventDescription: "Go to the woods ", startDate: Date(year: 2020, month: 01, day: 20, hour: 14, minute: 00, second: 00), endDate: Date(year: 2020, month: 01, day: 20, hour: 20, minute: 00, second: 00))
//               firebase.addEvent(apartmentKey: "-Lx0lGNvQu6ggnCJDtgX", event: &event)
        reloadData()
    }
    
    func eventPopover(_ sender : Any){
           let id = (sender is UITapGestureRecognizer||sender is UILongPressGestureRecognizer) ? "newEvent" : "editEvent"
           
           let popoverTaskVC=storyboard?.instantiateViewController(identifier: id) as! UIViewController
           popoverTaskVC.modalPresentationStyle = .overCurrentContext
           
           present(popoverTaskVC, animated: true)
       }
       func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
           return .none
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let apartmentKey = UserDefaults.standard.string(forKey: "apartmentKey")
        firebase.fetchEventData(apartmentKey: apartmentKey!) { (events) in

            self.eventsArr=events
            self.reloadData()
               }

//        self.navigationController?.navigationBar.backgroundColor=util.hexStringToUIColor("#FFCCFF")
        
        
        dayView.autoScrollToFirstEvent = true
//        reloadData()
   
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
                event.color=util.hexStringToUIColor(myevent.tenantColor)
//                 event.isAllDay
                events.append(event)
            }
        }

        return events
    }
    
    
    
    // MARK: DayViewDelegate
    
    override func dayViewDidSelectEventView(_ eventView: EventView) {
      guard let descriptor = eventView.descriptor as? Event else {
        return
      }
        
        print("Event has been selected: \(descriptor) \(String(describing: descriptor.text))")
    }

    override func dayViewDidLongPressEventView(_ eventView: EventView) {
      guard let descriptor = eventView.descriptor as? Event else {
        return
//            self.eventPopover(
      }
      print("Event has been longPressed: \(descriptor) \(String(describing: descriptor.userInfo))")
    }

    override func dayView(dayView: DayView, didLongPressTimelineAt date: Date) {
      print("Did long press timeline at date \(date)")
        //add new event
    }
}
