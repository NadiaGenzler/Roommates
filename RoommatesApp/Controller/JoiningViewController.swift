//
//  JoiningViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class JoiningViewController: UIViewController, UIPopoverPresentationControllerDelegate{
    
    var firebase=FirebaseHelper.shared
    
    //will be filled automatically once the group created
    @IBOutlet weak var apartmentKey: UITextField!
    @IBOutlet weak var imageView: CircularImageView!
    
    @IBOutlet weak var colorView: RoundView!
    var stringColor:String = ""
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
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
        
        var tenant=Tenant(name: name.text!, phoneNumber: phone.text!, password: password.text!,userColorString: stringColor)
        firebase.addTenant(apartmentKey: apartmentKey.text!, tenant: &tenant)
    }
    
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imagepicker=UIImagePickerController()
        imagepicker.delegate=self
        present(imagepicker,animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        
        
        
        
        
        
        
//        textField.delegate=self
        

    }
    
    
    
    
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
           if let keyboard=(notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
//               inflateView(keyboard)
           }
       }

    
//    func inflateView(_ keyboard:CGRect){
//        print(keyboard.height)
//        let v=UIView(frame: CGRect(x: 0, y: 0, width: keyboard.width, height: view.frame.height-keyboard.height))
//        v.backgroundColor=UIColor.gray
//        let lable=UILabel()
//        lable.text="bottom"
//        lable.translatesAutoresizingMaskIntoConstraints=false
//
//
//        view.addSubview(v)
//
//        v.addSubview(lable)
//
//        NSLayoutConstraint.activate([
//            lable.centerYAnchor.constraint(equalTo: v.bottomAnchor)])
//    }
   


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
