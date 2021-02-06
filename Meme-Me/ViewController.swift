//
//  ViewController.swift
//  Meme-Me
//
//  Created by Leonardo Saippa on 06/02/21.
//

import UIKit

class ViewController: UIViewController,
UIImagePickerControllerDelegate & UINavigationControllerDelegate {


    
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var pickImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField(topText, text: "TOP")
        configureTextField(bottomText, text: "BOTTOM")
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
        
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available")
            imagePicker.sourceType = .camera

        } else {
            print("Camera isn`t available")
            imagePicker.sourceType = .photoLibrary

        }
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print("imagePickerController")

        let imageUrl = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        pickImage.image = imageUrl
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel")
        dismiss(animated: true, completion: nil)
    }
    

}

