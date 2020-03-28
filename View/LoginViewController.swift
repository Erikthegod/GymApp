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
    
    var usuario : Usuario?
    var mensaje : MensajeResult?
    let preferences = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.emailTextField.text = "prueba"
        self.passwordTextField.text = "prueba"
    }
    
    @IBAction func loginPress(_ sender: Any) {
        if let email = self.emailTextField.text, let password = self.passwordTextField.text, (email.count > 0 && password.count > 0) {
            login(email: email, password: password)
        } else {
            let alert = UIAlertController(title: "Usuario y contraseña incorrectos", message: "Rellena los campos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert,animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueListaUsuarios" {
            let destinacionViewController = segue.destination as! ClientsUsersViewController
            destinacionViewController.usuario = self.usuario
        } else if segue.identifier == "segueUsuario" {
            let tabCtrl: UITabBarController = segue.destination as! UITabBarController
            let destinationVC = tabCtrl.viewControllers![0] as! RutinasViewController
            destinationVC.usuario = self.usuario
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func login(email:String, password:String){
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        var urlRequest = URLRequest(url: URL(string: "http://localhost:3001/login")!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyRequest: [String:Any] = ["email":email,"password":password]
        let json = try? JSONSerialization.data(withJSONObject: bodyRequest)
        urlRequest.httpBody = json
        
        let task = urlSession.dataTask(with: urlRequest) { (data,response,error) in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Ha habido un error al iniciar sesión", message: error?.localizedDescription , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
                return
            }
            
            DispatchQueue.main.async {
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(LoginResult.self, from: data)
                    if var usuario = result.usuario, let token = result.token{
                        usuario.token = token
                        self.preferences.set(token, forKey: "token")
                        self.usuario = usuario
                        if self.usuario!.rol == "ENTRENADOR_ROLE"{
                            self.performSegue(withIdentifier: "segueListaUsuarios" , sender: nil)
                        } else {
                            self.performSegue(withIdentifier: "segueUsuario" , sender: nil)
                        }
                    } else {
                        self.mensaje = result.err
                        let alert = UIAlertController(title: "Ha habido un error", message: self.mensaje!.message , preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        return
                    }
                } catch {
                    let alert = UIAlertController(title: "Ha habido un error al iniciar sesión", message: error.localizedDescription , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
            }
        }
        
        task.resume()
    }
    
}
