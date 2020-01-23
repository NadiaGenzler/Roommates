//
//  JoiningViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class JoiningViewController: UIViewController, UIPopoverPresentationControllerDelegate{
    
    @IBOutlet var scroll: UIScrollView!
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
        firebase.addTenant(apartmentKey: apartmentKeyTF.text!, tenant: &tenant)
        
//        if let apartKey = apartmentKeyTF.text{
//            UserDefaults.standard.set(apartKey, forKey: "apartKey")
//        }
//        if let name = name.text{
//            UserDefaults.standard.set(name, forKey: "name")
//        }
//        if let apartKey = apartmentKeyTF.text{
//            UserDefaults.standard.set(apartKey, forKey: "apartKey")
//        }
        
        
    }
    
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imagepicker=UIImagePickerController()
        imagepicker.delegate=self
        present(imagepicker,animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        apartmentNameTF.text=apartmentName
//        apartmentKeyTF.text=apartmentKey
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
        
//        textField.delegate=self
        

    }
    
    
    var keyboardOpened = false
    
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
           if let keyboard=(notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
               inflateView(keyboard)
           }
       }
    
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
              if let keyboard=(notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
                  closeView(keyboard)
              }
          }
    
    func inflateView(_ keyboard:CGRect){
        print(keyboard.height)

        if keyboardOpened == false{
            scroll.contentSize = CGSize(width: keyboard.width, height: view.frame.height-keyboard.height)
            self.view.frame = CGRect(x: 0, y: 0, width: keyboard.width, height: view.frame.height-keyboard.height)
            print("open")
            keyboardOpened = true
        }else{
            
            scroll.contentSize = CGSize(width: keyboard.width, height: view.frame.height+keyboard.height)
            self.view.frame = CGRect(x: 0, y: 0, width: keyboard.width, height: view.frame.height+keyboard.height)
            print("closed")
            keyboardOpened = false
        }
        
    }
    
   func closeView(_ keyboard:CGRect){
    self.view.frame = CGRect(x: 0, y: 0, width: keyboard.width, height: view.frame.height+keyboard.height)
    print(keyboard.height)
    print("closed")
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
