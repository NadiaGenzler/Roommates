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
    
    static let shared=FirebaseHelper()
    
    private init(){
        ref = Database.database().reference()
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
    
    func addEvent(apartmentKey:String, event: inout Event){
        guard let eventKey=self.ref.child(apartmentKey).child("events").childByAutoId().key else {return}
        event.eventKey=eventKey
        
        let childUpdates=["/Apartment/\(apartmentKey)/events/\(eventKey)":event.toDictionary()]
        ref.updateChildValues(childUpdates)
    }
    
    
    
    //MARK: Read from FireBase
    
    func fetchApartmentData(apartmentKey:String, complition: @escaping (Apartment)->Void){
        ref.child("Apartment").child(apartmentKey).observe(.value) { (snapshot) in
            let apartmentDict=snapshot.value as? [String:Any] ?? [:]
          
            let apartment = Apartment(fromDictionary: apartmentDict)
            complition(apartment)
           
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
