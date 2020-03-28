//
//  SignInViewController.swift
//  GymApp
//
//  Created by Eric Martin Gálan on 17/11/2018.
//  Copyright © 2018 Eric Martin Gálan. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {

    var usuario : Usuario?
    var mensaje : MensajeResult?
    let preferences = UserDefaults.standard

    
    @IBOutlet weak var emailSignIn: RoundTextField!
    @IBOutlet weak var passwordSignIn: RoundTextField!
    @IBOutlet weak var nameSignIn: RoundTextField!
    @IBOutlet weak var lastNameSignIn: RoundTextField!
    @IBOutlet weak var heightSignIn: UILabel!
    @IBOutlet weak var weightSignIn: UILabel!
    @IBOutlet weak var telephoneSignIn: RoundTextField!
    @IBOutlet weak var birthdateSignIn: UIDatePicker!
    @IBOutlet weak var personalTrainnerSignIn: UISwitch!
    
    @IBAction func heightStepperSignIn(_ sender: UIStepper) {
        let value = Int(sender.value)
        heightSignIn.text = String(value)
    }
    
    @IBAction func weightStepperSignIn(_ sender: UIStepper) {
        let value = Int(sender.value)
        weightSignIn.text = String(value)
    }
    
    @IBAction func signIn(_ sender: Any) {
        if let email = self.emailSignIn.text, let password = self.passwordSignIn.text, let nombre = self.nameSignIn.text, let apellidos = self.lastNameSignIn.text, let altura = Int(self.heightSignIn.text!), let pesoInicial = Int(self.weightSignIn.text!), let numero = Int(self.telephoneSignIn.text!), let fechaNacimiento = self.birthdateSignIn, let entrenadorPersonal = self.personalTrainnerSignIn,
            (email.count > 0 && password.count > 0 && nombre.count > 0 && apellidos.count > 0 && altura > 0 && pesoInicial > 0) {
            
            var rol = "USER_ROLE"
            if(entrenadorPersonal.isOn){
                rol = "ENTRENADOR_ROLE"
            }
            
            let urlSession = URLSession(configuration: URLSessionConfiguration.default)
            var urlRequest = URLRequest(url: URL(string: "http://localhost:3001/usuario")!)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let bodyRequest: [String:Any] = ["email":email,"password":password,"nombre": nombre,"apellidos" : apellidos, "altura": altura,"pesoInicial" :pesoInicial, "numero" : numero,"fechaNacimiento":fechaNacimiento.date.description,"rol":rol,"estado" : true,"publico" :true]
            let json = try? JSONSerialization.data(withJSONObject: bodyRequest)
            urlRequest.httpBody = json
            
            let task = urlSession.dataTask(with: urlRequest) { (data,response,error) in
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Ha habido un error al conectarse al servidor", message: error?.localizedDescription , preferredStyle: .alert)
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
                            self.performSegue(withIdentifier: "segueUsuario" , sender: nil)
                        } else {
                            self.mensaje = result.err
                            let alert = UIAlertController(title: "Ha habido un error", message: self.mensaje!.message , preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                            return
                        }
                    } catch {
                        let alert = UIAlertController(title: "Ha habido un error al registrarse", message: error.localizedDescription , preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        return
                    }
                }
            }
            
            task.resume()
            
         
        } else {
            let alert = UIAlertController(title: "Usuario y contraseña incorrectos", message: "Rellena los campos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert,animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mostrarListaUsuarios" {
            let destinacionViewController = segue.destination as! ClientsUsersViewController
            destinacionViewController.usuario = self.usuario
        } else if segue.identifier == "segueUsuario" {
        }
        
    }
}
