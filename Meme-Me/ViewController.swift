//
//  ViewController.swift
//  Meme-Me
//
//  Created by Leonardo Saippa on 06/02/21.
//

import UIKit

class ViewController: UIViewController {

    
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


}

