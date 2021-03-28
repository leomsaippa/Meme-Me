//
//  MemeTableViewController.swift
//  Meme-Me
//
//  Created by Leonardo Saippa on 27/03/21.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController {
        
    let memeCellID = "MemesTableViewCell"
    
    var memes: [Meme]! {
        let object =  UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        print(appDelegate.memes.count)
        return appDelegate.memes
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }


        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: memeCellID , for: indexPath)
        print(indexPath)
       
        cell.imageView!.image = self.memes[indexPath.row].memedImage
        cell.textLabel!.text = self.memes[indexPath.row].topText + "+" + self.memes[indexPath.row].bottomText
           
       return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            print("remove")

        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          self.performSegue(withIdentifier: "segueTableVCtoDetailVC", sender: self)
    }
    
    // Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueTableVCtoDetailVC") {
            let destVC: MemeDetailViewController = segue.destination as! MemeDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            destVC.currentMeme = self.memes[indexPath!.row]
        }
    }
}
