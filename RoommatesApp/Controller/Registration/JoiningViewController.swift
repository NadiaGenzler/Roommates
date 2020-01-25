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
    
    var delegate:ViewController?
    @IBOutlet var scrollView: UIScrollView!
    var firebase=FirebaseHelper.shared
    
    //will be filled automatically once the group created
    @IBOutlet weak var apartmentKeyTF: UITextField!
    var apartmentKey:String?
    @IBOutlet weak var apartmentNameTF: UITextField!
    var apartmentName:String?
    
    @IBOutlet weak var imageView: CircularImageView!
    
    @IBOutlet weak var colorView: RoundView!
    var stringColor:String = "#ffffff"
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    var popoverVC:ColorPickerViewController?
    
    @IBAction func colorPicker(_ sender: UITapGestureRecognizer) {
        
       popoverVC=storyboard?.instantiateViewController(withIdentifier: "colorPalette") as? ColorPickerViewController
        
        guard let popoverVC=popoverVC else {return}
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize=CGSize(width: 210, height: 110)
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
        var tenant=Tenant(apartmentKey:apartmentKeyTF.text! ,name: name.text!, password: password.text!,userColorString: stringColor)
        
        firebase.addTenant(apartmentKey: apartmentKeyTF.text!, tenant: &tenant) { (currentTenant) in
            
            
            UserDefaults.standard.set(apartmentNameTF.text!, forKey: "apartmentName")
            
            
            UserDefaults.standard.set(currentTenant.apartmentKey, forKey: "apartmentKey")
            UserDefaults.standard.set(currentTenant.tenantKey, forKey: "tenantKey")
            
            UserDefaults.standard.set(currentTenant.name, forKey: "name")
            UserDefaults.standard.set(currentTenant.password, forKey: "password")
            UserDefaults.standard.set(currentTenant.userColorString, forKey: "userColorString")
            
//            if let apartKey = currentTenant.apartmentKey{
//                UserDefaults.standard.set(apartKey, forKey: "apartmentKey")
//            }
//            if let name = name.text{
//                UserDefaults.standard.set(name, forKey: "name")
//            }
//            if let password = password.text{
//                UserDefaults.standard.set(password, forKey: "password")
//            }
//            if let password = password.text{
//                UserDefaults.standard.set(password, forKey: "color")
//            }
            
            self.delegate?.nav?.dismiss(animated: true)
            //how do I dismiss the storyboard???
            
            
            
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
        apartmentKeyTF.text=apartmentKey
        
       // scrollView.isScrollEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
//        textField.delegate=self
        

    }
    
    
    var keyboardClosed = true

    @objc func keyboardWillShow(_ notification: NSNotification) {
           if let keyboard=(notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
               handleScrollView(keyboard)
           }
       }

    func handleScrollView(_ keyboard:CGRect){
        
        if keyboardClosed {
         //   scrollView.isScrollEnabled = true
            scrollView.contentSize = CGSize(width: keyboard.width, height: view.frame.height-keyboard.height)
            scrollView.frame = CGRect(x: 0, y: 0, width: keyboard.width, height: view.frame.height-keyboard.height)
    
            keyboardClosed = false
        }else{
           // scrollView.isScrollEnabled = false
            scrollView.contentSize = CGSize(width: keyboard.width, height: view.frame.height)
            scrollView.frame = CGRect(x: 0, y: 0, width: keyboard.width, height: view.frame.height)
            
            keyboardClosed = true
        }
        
    }
}



extension JoiningViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}


extension JoiningViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //cancled
        print("Cancled")
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        print("Info", info[.imageURL])
//        
//        var imgUrl=info[.imageURL] as! URL
//        firebase.uploadImage(url: imgUrl)
        
        picker.dismiss(animated: true)
        
        
        guard let image = info[.originalImage] as? UIImage else {return}
        imageView.image = image
    }
}
