//
//  LogInViewController.swift
//  MySmallWorld
//
//  Created by Drew Scheffer on 5/20/21.
//

import UIKit
import Firebase

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    var continueButton: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        

        continueButton = RoundedButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        continueButton.setTitleColor(secondaryColor, for: .normal)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        continueButton.center = CGPoint(x: view.center.x, y: view.frame.height - continueButton.frame.height)
        continueButton.highlightedColor = UIColor(white: 1.0, alpha: 1.0)
        continueButton.defaultColor = .white
        continueButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        toggleContinueButton(isEnabled: false)
        view.addSubview(continueButton)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func toggleContinueButton(isEnabled: Bool){
        if isEnabled {
            continueButton.alpha = 0.5
        }else{
            continueButton.alpha = 1.0
        }
    }
    
    
    func errorLoggingIn(_ error: String) {
        let alertController = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
        self.toggleContinueButton(isEnabled: false)
    }
    
    @objc func handleSignIn() {
        toggleContinueButton(isEnabled: true)
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let e = error {
                    self.errorLoggingIn(e.localizedDescription)
                }else{
                    self.toggleContinueButton(isEnabled: false)
                    self.performSegue(withIdentifier: K.logInSegueIden, sender: self)
                }
            }
        }
    }
    
}
