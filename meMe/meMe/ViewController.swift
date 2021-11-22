//
//  ViewController.swift
//  meMe
//
//  Created by Jack McCabe on 11/18/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var midScreenImage: UIImageView!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        print("sd")
        super.viewDidLoad()
        setTextAttributes()
        print("a")
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        print("b")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func setTextAttributes() {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.borderStyle = .none
        bottomTextField.borderStyle = .none
        topTextField.backgroundColor = .clear
        bottomTextField.backgroundColor = .clear
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
     
    }
    func textFieldDidBeginEditing(_ textField: UITextField) -> Bool{
        if(textField.text == "TOP" || textField.text == "BOTTOM"){
            textField.text = ""
            return true
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField)-> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor:UIColor.black,
        NSAttributedString.Key.foregroundColor:UIColor.black,
        NSAttributedString.Key.backgroundColor:UIColor.clear,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:1.01 ]

    func subscribeToKeyboardNotifications(){
        print("0")
        NotificationCenter.default.addObserver(self, selector:   #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object:nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        print("1")
    }
    
    
    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
   @objc func keyboardWillHide(_ notification: Notification){
       print("2")
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification)->CGFloat{
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
        
    }
    
   @objc func keyboardWillShow(_ notification:Notification){
        print("3")
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    
    @IBAction func settingImage(_ sender: Any) {
        var pickerController = UIImagePickerController()
        
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
       
        present(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        var pickerController = UIImagePickerController()
        
        pickerController.delegate = self
        pickerController.sourceType = .camera
        
        present(pickerController, animated:true, completion:nil)
        
    }
    

    
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
         
         if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
             midScreenImage.image = selectedImage
                }
         
         if let im = info[UIImagePickerController.InfoKey.imageURL]{
             print("\(im)")
         }
         
         dismiss(animated: true, completion:nil)
         
     }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion:nil)
    }

    

    
}

