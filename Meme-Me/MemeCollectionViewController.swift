//
//  MemeCollectionViewController.swift
//  Meme-Me
//
//  Created by Leonardo Saippa on 27/03/21.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController, UITextFieldDelegate {
    
    // MARK: - Properties: Variables and Constants
    
    @IBOutlet weak var memeCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    let memeCollectionCellID = "MemeCollectionViewCell"
    
    var memes: [Meme]! {
        let object =  UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    
     override func viewDidLoad() {
           super.viewDidLoad()
        
        //Storyboard autoresizing doesnt work properly without this.
        memeCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let space:CGFloat = 3.0
        let widthDimension = (view.frame.size.width - (2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: widthDimension, height: widthDimension)
       }
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
       
         memeCollectionView!.reloadData()
     }

     override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return self.memes.count
     }

     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: memeCollectionCellID , for: indexPath) as! MemeCollectionViewCell
         print(indexPath)
        cell.collectionImageView.image = self.memes[indexPath.row].originalImage
        return cell
     }
    
       override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
              self.performSegue(withIdentifier: "memeCollectionVCtoDetailVC", sender: self)
          }

    // Prepare for Segue from selected Item
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "memeCollectionVCtoDetailVC") {
               let destVC: MemeDetailViewController = segue.destination as! MemeDetailViewController
            let indexPath = self.memeCollectionView.indexPathsForSelectedItems?.first
               destVC.currentMeme = self.memes[indexPath!.row]
           }
        }


}


