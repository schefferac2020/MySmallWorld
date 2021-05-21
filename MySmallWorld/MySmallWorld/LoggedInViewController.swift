//
//  LoggedInViewController.swift
//  MySmallWorld
//
//  Created by Drew Scheffer on 5/20/21.
//

import UIKit
import Firebase

class LoggedInViewController: UIViewController {

    @IBAction func logOutButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "Are you sure that you want to sign out?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
            self.signOut()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let error  {
            print("Failed to sign out: ", error)
        }
    }

}
