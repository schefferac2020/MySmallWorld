//
//  RegisterViewController.swift
//  MySmallWorld
//
//  Created by Drew Scheffer on 5/20/21.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var continueButton: RoundedButton!
    
    var activityIndView: UIActivityIndicatorView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        //Add the continue button
        continueButton = RoundedButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        continueButton.setTitleColor(secondaryColor, for: .normal)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        continueButton.center = CGPoint(x: view.center.x, y: view.frame.height - continueButton.frame.height)
        continueButton.highlightedColor = UIColor(white: 1.0, alpha: 1.0)
        continueButton.defaultColor = .white
        continueButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        toggleContinueButton(isEnabled: false)
        view.addSubview(continueButton)
        
        //Add the activityView (loading swirly)
        activityIndView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndView.color = primaryColor
        activityIndView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityIndView.center = continueButton.center
        view.addSubview(activityIndView)
        
        usernameField.delegate = self
        //usernameField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        emailField.delegate = self
        //emailField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordField.delegate = self
        //passwordField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    

    func toggleContinueButton(isEnabled: Bool){
        if isEnabled {
            continueButton.alpha = 0.5
        }else{
            continueButton.alpha = 1.0
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSignUp() {
        toggleContinueButton(isEnabled: true)
        
        if let email = emailField.text, let password = passwordField.text, let username = usernameField.text {
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if let e = error {
                    print(e.localizedDescription)
                    return;
                }
                
                guard let uid = authResult?.user.uid else { return }
                
                let values = ["email": email, "username": username]
                Database.database().reference().child("users").child(uid).updateChildValues(values) { (error, ref) in
                    if let e = error {
                        print(e.localizedDescription)
                        return;
                    }
                }
                
                print("Succesffully Signed user up!")
                self.performSegue(withIdentifier: K.registerSegueIden, sender: self)
                
                
            }
        }
    }
    
    

}
