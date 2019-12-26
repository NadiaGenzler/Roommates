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
    
    func addApartment(apartment:Apartment){
        guard let apartmentKey=self.ref.childByAutoId().key else {return}
//
//        let apartmentPost=Apartment(name: "Home", id: "1234", tenants: [Tenant(name: "nadia5"), Tenant(name: "asdfg")])
        let childUpdates=["/Apartment/\(apartmentKey)":apartment.toDictionary()]
        
        ref.updateChildValues(childUpdates)
    }
    
    func addTenant(apartmentKey:String, tenant: inout Tenant){
        guard let tenantKey=self.ref.child(apartmentKey).child("tenants").childByAutoId().key else {return}
        tenant.tenantKey=tenantKey
        
        let childUpdates=["/Apartment/\(apartmentKey)/tenants/\(tenantKey)":tenant.toDictionary()]
        ref.updateChildValues(childUpdates)
        
    }
    
    func removeTenant(apartmentKey:String ,tenantKey:String){
        let refForRemove=Database.database().reference(withPath: "/Apartment/\(apartmentKey)/tenants/\(tenantKey)")
        refForRemove.removeValue()

    }
    
    func addTask(apartmentKey:String, task: inout Task){
        guard let taskKey=self.ref.child(apartmentKey).child("tasks").childByAutoId().key else {return}
        task.key=taskKey
        
        let childUpdates=["/Apartment/\(apartmentKey)/tasks/\(taskKey)":task.toDictionary()]
        ref.updateChildValues(childUpdates)
        
    }
    
    //MARK: Read from FireBase
    
    func fetchApartmentData(apartmentKey:String, complition: @escaping (Apartment)->Void){
        ref.child("Apartment").child(apartmentKey).observe(.value) { (snapshot) in
            let aprtmentDict=snapshot.value as? [String:Any] ?? [:]
            
//            let name:String = aprtmentDict["name"] as! String
//            let key:String = aprtmentDict["key"] as! String
//            let tenants:[Tenant] = aprtmentDict["talents"] as! [Tenant]
//            let tasks:[Task] = aprtmentDict["tasks"] as! [Task]
//            
            let apartment = Apartment(fromDictionary: aprtmentDict)
            complition(apartment)
           
        }
    }
    
    
    
    func fetchTasks(){
        
    }
    
    
    

    
    
}
