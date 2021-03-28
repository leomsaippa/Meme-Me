//
//  MemeDetailViewController.swift
//  Meme-Me
//
//  Created by Leonardo Saippa on 27/03/21.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var currentMeme: Meme!
    
    @IBOutlet weak var detailedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.detailedImageView.image = currentMeme.memedImage
       }
}
