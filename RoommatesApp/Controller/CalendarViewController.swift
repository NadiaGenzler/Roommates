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
        
    
    
        
    
    
        lazy var customCalendar: Calendar = {
          let customNSCalendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
          customNSCalendar.timeZone = TimeZone(abbreviation: "CEST")!
          let calendar = customNSCalendar as Calendar
            
          return calendar
        }()
    
        override func loadView() {
          calendar = customCalendar
          dayView = DayView(calendar: calendar)
          view = dayView
        }
    
    @IBAction func addEvent(_ sender: UIBarButtonItem) {
//        var event=MyEvent(eventName: "gogogogo", eventDescription: "Go shopping ", startDate: Date(year: 2020, month: 01, day: 14, hour: 14, minute: 00, second: 00), endDate: Date(year: 2020, month: 01, day: 14, hour: 20, minute: 00, second: 00))
//        firebase.addEvent(apartmentKey: "-Lx0lGNvQu6ggnCJDtgX", event: &event)
//        reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsArr=[MyEvent(eventDescription: "Go shopping ", startDate: Date(year: 2020, month: 01, day: 14, hour: 14, minute: 00, second: 00), endDate: Date(year: 2020, month: 01, day: 14, hour: 20, minute: 00, second: 00)),
        MyEvent(eventDescription: "Travel", startDate: Date(year: 2020, month: 01, day: 16, hour: 14, minute: 00, second: 00), endDate: Date(year: 2020, month: 01, day: 16, hour: 20, minute: 00, second: 00))]
//        firebase.fetchEventData(apartmentKey: "-Lx0lGNvQu6ggnCJDtgX") { (events) in
//                   
//                  // print(events)
//          //  eventsArr=events
//                   
//               }
        self.navigationController?.navigationBar.backgroundColor=util.hexStringToUIColor("#FFCCFF")
        
        
        dayView.autoScrollToFirstEvent = true
        reloadData()
    }
    
    // MARK: EventDataSource
    
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        var events = [Event]()
        
        if var myEvents=eventsArr{
            print(myEvents)
            for myevent in myEvents {
                print(myevent)
                let event = Event()
                
                event.text=myevent.eventDescription
                event.startDate = myevent.startDate
                event.endDate = myevent.endDate
                event.color=util.hexStringToUIColor("#FFCCFF")
                
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
      }
      print("Event has been longPressed: \(descriptor) \(String(describing: descriptor.userInfo))")
    }

    override func dayView(dayView: DayView, didLongPressTimelineAt date: Date) {
      print("Did long press timeline at date \(date)")
        //add new event
    }
}
