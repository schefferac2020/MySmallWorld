//
//  ViewController.swift
//  MySmallWorld
//
//  Created by Drew Scheffer on 5/20/21.
//

import UIKit
import Firebase

class MainMenuViewController: UIViewController {

    @IBOutlet weak var logInButton: RoundedButton!
    @IBOutlet weak var registerButton: RoundedButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
       // logInButton.defaultColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        logInButton.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        registerButton.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        authenticateUserAndConfigureView()
    }
    
    
    func authenticateUserAndConfigureView() {
        if (Auth.auth().currentUser != nil){
            self.performSegue(withIdentifier: K.alreadyLoggedInSegue, sender: self)
        }
    }
}

