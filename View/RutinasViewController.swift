//
//  UserViewController.swift
//  GymApp
//
//  Created by Eric Martin Galan on 04/08/2019.
//  Copyright © 2019 Eric Martin Gálan. All rights reserved.
//

import UIKit

class RutinasViewController: UIViewController{
    var rutinas : [Rutina] = []
    var rutina : Rutina!
    var usuario : Usuario!
    
    @IBOutlet weak var tablaRutinas:UITableView!
    var placeholderImage : UIImage!
    let preferences = UserDefaults.standard
    var nameUser : String!
    
    override func viewDidLoad() {
        let token = preferences.string(forKey: "token")
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        var urlRequest = URLRequest(url: URL(string: "http://localhost:3001/rutinasUsuario/\(usuario._id)")!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(token!, forHTTPHeaderField: "token")
        
        let task = urlSession.dataTask(with: urlRequest) { (data,response,error) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                do{
                    let decoder = JSONDecoder()
                    let rutinas = try decoder.decode(RutinasResult.self, from: data)
                    self.rutinas = rutinas.rutinas!
                    self.tablaRutinas.reloadData()
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
    
    
}

extension RutinasViewController: UITableViewDataSource {
    //    MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rutinas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rutina = self.rutinas[indexPath.row]
        let idCelda = "celdaRutina"
        let cell = tableView.dequeueReusableCell(withIdentifier: idCelda, for: indexPath)
        
        cell.textLabel?.text = rutina.nombre
        return cell
    }
    
}
