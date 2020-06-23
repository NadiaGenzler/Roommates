//
//  JoiningViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class JoiningViewController: UIViewController, UIPopoverPresentationControllerDelegate{
    
    // fix the location of the scroll when closed after being opened
    //fix the color picker when the keyboard is open
   
    @IBOutlet var scrollView: UIScrollView!
    var firebase=FirebaseHelper.shared
    var utility=Utilities.shared
    var apartmentsArr:[Apartment]=[]
    //will be filled automatically once the group created
    @IBOutlet weak var apartmentNameTF: UITextField!
    var apartmentName:String?
    
    @IBOutlet weak var errorLable: UILabel!
    @IBOutlet weak var imageView: CircularImageView!
    var imgUrl:URL?
    
    @IBOutlet weak var colorView: RoundView!
    var stringColor:String = "#ffffff"
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    var popoverVC:ColorPickerViewController?
    
//    MARK: ColorPicker
    @IBAction func colorPicker(_ sender: UITapGestureRecognizer) {
        
        popoverVC=storyboard?.instantiateViewController(withIdentifier: "colorPalette") as? ColorPickerViewController
        
        guard let popoverVC=popoverVC else {return}
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize=CGSize(width: 175, height: 95)
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
    
    
    @IBAction func joinButton(_ sender: UIButton) {
        //add function tha cheks that the fields are not empty
        
        for i in 0..<apartmentsArr.count{
            // cheks if the apartment that the user want to join exists
            if apartmentsArr[i].name==apartmentNameTF.text?.trimmingCharacters(in: .whitespaces){
                
                var tenant=Tenant(apartmentKey: apartmentsArr[i].apartmentKey! ,name: name.text!, password: password.text!,userColorString: stringColor)
                
                firebase.addTenant(apartmentKey: apartmentsArr[i].apartmentKey! , tenant: &tenant) { (currentTenant) in
                    
                    UserDefaults.standard.set(apartmentNameTF.text!, forKey: "apartmentName")
                    UserDefaults.standard.set(currentTenant.apartmentKey, forKey: "apartmentKey")
                    UserDefaults.standard.set(currentTenant.tenantKey, forKey: "tenantKey")
                    UserDefaults.standard.set(currentTenant.name, forKey: "name")
                    UserDefaults.standard.set(currentTenant.password, forKey: "password")
                    UserDefaults.standard.set(currentTenant.userColorString, forKey: "userColorString")
                    
                    if let url=imgUrl{
                     firebase.uploadImage(url: url, apartmentKey: currentTenant.apartmentKey, tenantKey: currentTenant.tenantKey!)
                    }
                }
                
                let nav=self.utility.showMainStoryboard()
                nav.modalPresentationStyle = .overFullScreen
                nav.modalTransitionStyle = .coverVertical
                self.present(nav,animated: true)
                
            }else if i==apartmentsArr.count-1{
                errorLable.isHidden=false
            }
        }
       
    }
    
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imagepicker=UIImagePickerController()
        imagepicker.delegate=self
        present(imagepicker,animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apartmentNameTF.text=apartmentName
        
        firebase.fetchAllApartmentsData { (apartments) in
            self.apartmentsArr=apartments
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        
    }
    
    //MARK: KeyBoard and ScrollView handle
    
    var keyboardClosed = true
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboard=(notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            handleScrollView(keyboard)
        }
        
        
    }
    
    func handleScrollView(_ keyboard:CGRect){
        
        if keyboardClosed {
            scrollView.contentSize = CGSize(width: keyboard.width, height: view.frame.height-keyboard.height)
            scrollView.frame = CGRect(x: 0, y: 0, width: keyboard.width, height: view.frame.height-keyboard.height-60)
            
            keyboardClosed = false
        }
//        else{
////            scrollView.contentSize = CGSize(width: keyboard.width, height: view.frame.height)
//            scrollView.frame = CGRect(x: 0, y: 0, width: keyboard.width, height: view.frame.height)
//
//            keyboardClosed = true
//        }
        
    }
}


//MARK: Extentions for Imagepicker


extension JoiningViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        picker.dismiss(animated: true)
        
        imgUrl=info[.imageURL] as? URL
    
        guard let image = info[.originalImage] as? UIImage else {return}
        imageView.image = image
        
        let pngImage=image.pngData()
        UserDefaults.standard.set(pngImage, forKey: "UserImagePng")
    }
}
