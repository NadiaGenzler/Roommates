//
//  JoiningViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class JoiningViewController: UIViewController {

    
   
    @IBOutlet weak var imageView: CircularImageView!
    
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imagepicker=UIImagePickerController()
        imagepicker.delegate=self
        present(imagepicker,animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
//        textField.delegate=self
        
//        let imageData = imageView.image?.pngData()
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
        //[] print("Info", info)
 
        picker.dismiss(animated: true)
        
        
        guard let image = info[.originalImage] as? UIImage else {return}
        imageView.image = image
    }
}
