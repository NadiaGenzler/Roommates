//
//  FirebaseHelper.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 26/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit
import Firebase

class FirebaseHelper {
    var ref: DatabaseReference!
    let storageRef:StorageReference!
    
    static let shared=FirebaseHelper()
    
    private init(){
        ref = Database.database().reference()
        storageRef=Storage.storage().reference()
    }
    
    
    //MARK: Write to FireBase
    
    // add and update together
    func addApartment(apartment: inout Apartment){
        guard let apartmentKey=self.ref.childByAutoId().key else {return}
        apartment.apartmentKey=apartmentKey
        
        let childUpdates=["/Apartment/\(apartmentKey)":apartment.toDictionary()]
        ref.updateChildValues(childUpdates)
    }
    
    func addTenant(apartmentKey:String, tenant: inout Tenant){
        guard let tenantKey=self.ref.child(apartmentKey).child("tenants").childByAutoId().key else {return}
        tenant.tenantKey=tenantKey
        
        let childUpdates=["/Apartment/\(apartmentKey)/tenants/\(tenantKey)":tenant.toDictionary()]
        ref.updateChildValues(childUpdates)
        
    }
    
    
    func addTask(apartmentKey:String, task: inout Task){
        guard let taskKey=self.ref.child(apartmentKey).child("tasks").childByAutoId().key else {return}
        task.taskKey=taskKey
        
        let childUpdates=["/Apartment/\(apartmentKey)/tasks/\(taskKey)":task.toDictionary()]
        ref.updateChildValues(childUpdates)
        
    }
    
    func addEvent(apartmentKey:String, event: inout MyEvent){
        guard let eventKey=self.ref.child(apartmentKey).child("events").childByAutoId().key else {return}
        event.eventKey=eventKey
        
        let childUpdates=["/Apartment/\(apartmentKey)/events/\(eventKey)":event.toDictionary()]
        ref.updateChildValues(childUpdates)
    }
    
    //    func uploadImage(url:URL){
    //        let imagesRef = storageRef.child("images")
    //        print(imagesRef)
    //        let uploadTask=imagesRef.putFile(from: url)
    //    }
    
    //MARK: Read from FireBase
    
    func fetchApartmentData(apartmentKey:String, complition: @escaping (Apartment)->Void){
        ref.child("Apartment").child(apartmentKey).observe(.value) { (snapshot) in
            let apartmentDict=snapshot.value as? [String:Any] ?? [:]
            //          print(apartmentDict)
            
            let apartment = Apartment(fromDictionary: apartmentDict)
            complition(apartment)
            
        }
    }
    
    func fetchTenantData(apartmentKey:String, complition: @escaping ([Tenant])->Void){
        ref.child("Apartment").child(apartmentKey).child("tenants").observe(.value) { (snapshot) in
            let tenantDict=snapshot.value as? [String:Any] ?? [:]
            var tenants:[Tenant]=[]
            for (tenantKey,tenantValue ) in tenantDict{
                let tenantValues=tenantValue as![String:Any]
                let tenant=Tenant(fromDictionary: tenantValues)
                
                tenants.append(tenant)
            }
            
            complition(tenants)
            
        }
    }
    
    func fetchEventData(apartmentKey:String, complition: @escaping ([MyEvent])->Void){
        ref.child("Apartment").child(apartmentKey).child("events").observe(.value) { (snapshot) in
            let eventDict=snapshot.value as? [String:Any] ?? [:]
            var events:[MyEvent]=[]
            for (eventKey,eventValue) in eventDict{
                let eventValues=eventValue as![String:Any]
                let event=MyEvent(fromDictionary: eventValues)
                
                events.append(event)
            }
            
            complition(events)
            
        }
    }
    
        
    func fetchTaskData(apartmentKey:String, complition: @escaping ([Task])->Void){
        
        self.ref.child("Apartment").child(apartmentKey).child("tasks").observe(.value) { (snapshot) in
            var tasks:[Task]=[]
            
            let taskDict=snapshot.value as? [String:Any] ?? [:]
            for (taskKey,taskValue) in taskDict{
                let tasksValues=taskValue as! [String:Any]
                
                let task=Task(fromDictionary: tasksValues)
                
                tasks.append(task)
            }
                complition(tasks)
        
        }
    }
    
    
    
    //MARK: Remove from FireBase
    func removeApartment(apartmentKey:String){
        let refForRemove=Database.database().reference(withPath: "/Apartment/\(apartmentKey)")
        refForRemove.removeValue()
        
    }
    
    func removeTenant(apartmentKey:String ,tenantKey:String){
        let refForRemove=Database.database().reference(withPath: "/Apartment/\(apartmentKey)/tenants/\(tenantKey)")
        refForRemove.removeValue()
        
    }
    
    func removeTask(apartmentKey:String ,taskKey:String){
        let refForRemove=Database.database().reference(withPath: "/Apartment/\(apartmentKey)/tasks/\(taskKey)")
        refForRemove.removeValue()
        
    }
    
    func removeEvent(apartmentKey:String ,eventKey:String){
        let refForRemove=Database.database().reference(withPath: "/Apartment/\(apartmentKey)/events/\(eventKey)")
        refForRemove.removeValue()
        
    }
    
}
