//
//  ClientsUsersViewController.swift
//  GymApp
//
//  Created by Eric Martin Gálan on 18/11/2018.
//  Copyright © 2018 Eric Martin Gálan. All rights reserved.
//

import UIKit

class ClientsUsersViewController: UITableViewController {

    var usuarios : [Usuario] = []
    var usuario : Usuario!
    
    var placeholderImage : UIImage!
    let preferences = UserDefaults.standard
    var nameUser : String!
    
    override func viewDidLoad() {
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        var urlRequest = URLRequest(url: URL(string: "http://localhost:3001/usuariosClientes")!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(self.usuario.token!, forHTTPHeaderField: "token")
        
        let task = urlSession.dataTask(with: urlRequest) { (data,response,error) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                do{
                    let decoder = JSONDecoder()
                    let usuarios = try decoder.decode(UsuariosResult.self, from: data)
                    self.usuarios = usuarios.usuarios!
                    self.tableView.reloadData()
                } catch{
                    print(error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //    MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usuarios.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let usuario = self.usuarios[indexPath.row]
        let idCelda = "ClientUserCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: idCelda, for: indexPath) as! ClientUserTableViewCell
        
        cell.nameClientUser.text = usuario.nombre
        cell.emailClientUser.text = usuario.email
        cell.telephoneClientUser.text = String(usuario.numero!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cellNumber = self.tableView.indexPathForSelectedRow{
            let usuario = self.usuarios[cellNumber.row]
            let destinacionViewController = segue.destination as! RutinasViewController
            destinacionViewController.usuario = usuario
            preferences.set(usuario, forKey: "usuario")
        }
    }
    
}
