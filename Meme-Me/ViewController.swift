//
//  ViewController.swift
//  Meme-Me
//
//  Created by Leonardo Saippa on 06/02/21.
//

import UIKit


class ViewController: UIViewController,
UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate {


    
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var pickImage: UIImageView!
    @IBOutlet weak internal var navBar: UIToolbar!
    @IBOutlet weak internal var toolBar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shareButton.isEnabled = false
        configureTextField(topText, text: "TOP")
        configureTextField(bottomText, text: "BOTTOM")
        
        bottomText.delegate = self
        topText.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
   

    func configureTextField(_ textField: UITextField, text: String) {
        
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth: -5.0,
        ]
   
        textField.defaultTextAttributes = memeTextAttributes

        textField.text = text
        textField.textAlignment = .center
  
    }

    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        presentImagePickerWith(sourceType: .camera)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        presentImagePickerWith(sourceType: .photoLibrary)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print("imagePickerController")

        let imageUrl = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        pickImage.image = imageUrl
        shareButton.isEnabled = true
        dismiss(animated: true, completion: nil)
        
    }
    
    func presentImagePickerWith(sourceType: UIImagePickerController.SourceType) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary

        if(sourceType == .camera && UIImagePickerController.isSourceTypeAvailable(.camera)){
            print("Camera is available")
            imagePicker.sourceType = .camera

        }
        present(imagePicker, animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel")
        dismiss(animated: true, completion: nil)
    }
    
    
    func subscribeToKeyboardNotifications() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
        
        }
    
    
    @objc func keyboardWillShow(_ notification:Notification) {

        if bottomText.isEditing && view.frame.origin.y == 0 {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }

   
   @objc func keyboardWillHide(_ notification:Notification) {
        if bottomText.isEditing && view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    //When click return, hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

    @IBAction func cancelCurrentMeme(_ sender: Any) {
        // Removing current image and return to Sent Memes
        pickImage.image = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareCurrentPhoto(_ sender: Any) {
        //Generate memedImage
       let sharedImage = generateMemedImage()
        
        let activityView = UIActivityViewController(activityItems: [sharedImage], applicationActivities: nil)
            present(activityView, animated: true)
        
        activityView.completionWithItemsHandler = { activity, completed, items, error in
            if completed {
                self.save(memedImage: sharedImage)
                self.showAlert("Meme-Me", "Meme successfully shared")
                return
            } else {
                self.showAlert("Meme-Me", "Canceled")
            }
            if let shareError = error {
                self.showAlert("Meme-Me", "Error sharing meme: \(shareError.localizedDescription)")
            }
        }
    }
    
    func generateMemedImage() -> UIImage {

        // Hide toolbar and navbar
        isToHideTopAndBottomBars(_hide: true)

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // Show toolbar and navbar
        isToHideTopAndBottomBars(_hide: false)

        return memedImage
    }
    
    func isToHideTopAndBottomBars(_hide : Bool){
        self.toolBar.isHidden = _hide
        self.navBar.isHidden = _hide

    }
    func save(memedImage: UIImage) {
        
        // Create the meme
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: pickImage.image!, memedImage: memedImage)
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    //Set up Alerts
    func showAlert(_ alertTitle: String, _ alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:  nil ))
        
        self.present(alert,animated: true,completion: nil)
    
        }
    
}

