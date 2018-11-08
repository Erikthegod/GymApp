//
//  LoginViewController.swift
//  GymApp
//
//  Created by Eric Martin Gálan on 07/11/2018.
//  Copyright © 2018 Eric Martin Gálan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: RoundTextField!
    
    @IBOutlet weak var passwordTextField: RoundTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginPress(_ sender: Any) {
        if let email = self.emailTextField.text, let password = self.passwordTextField.text, (email.count > 0 && password.count > 0) {
            AuthService.shared.login(email: email, password: password)
        } else {
            let alert = UIAlertController(title: "Usuario y contraseña incorrectos", message: "Rellena los campos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert,animated: true)
        }
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

   

}
