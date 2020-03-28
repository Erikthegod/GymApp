//
//  RutinaActivaViewController.swift
//  GymApp
//
//  Created by Eric Martin Galan on 26/08/2019.
//  Copyright © 2019 Eric Martin Gálan. All rights reserved.
//

import UIKit

class RutinaActivaViewController: UIViewController{
    var rutina : Rutina!
    var usuario : Usuario!
    var sesiones : [Sesion]!
    
    @IBOutlet weak var tablaSesiones :UITableView!
    var placeholderImage : UIImage!
    let preferences = UserDefaults.standard
    var nameUser : String!
    
    override func viewDidLoad() {
        let token = preferences.string(forKey: "token")
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        var urlRequest = URLRequest(url: URL(string: "http://localhost:3001/rutina/\(usuario.rutinaActiva!)")!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(token!, forHTTPHeaderField: "token")
        
        let task = urlSession.dataTask(with: urlRequest) { (data,response,error) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                do{
                    let decoder = JSONDecoder()
                    let rutinaResult = try decoder.decode(RutinaResult.self, from: data)
                    self.rutina = rutinaResult.rutina!
                    var urlRequestSesion = URLRequest(url: URL(string: "http://localhost:3001/sesionesRutina/\(self.rutina._id!)")!)
                    urlRequestSesion.httpMethod = "GET"
                    urlRequestSesion.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                    urlRequestSesion.addValue(token!, forHTTPHeaderField: "token")
                    let task = urlSession.dataTask(with: urlRequestSesion) { (data,response,error) in
                        guard let data = data else {return}
                        DispatchQueue.main.async {
                            do{
                                let decoder = JSONDecoder()
                                let sesionesResult = try decoder.decode(SesionesResult.self, from: data)
                                self.sesiones = sesionesResult.sesiones!
                        
                                for sesion in self.sesiones{
                                    var urlRequestEjercicios = URLRequest(url: URL(string: "http://localhost:3001/ejerciciosSesion/\(sesion._id!)")!)
                                    urlRequestEjercicios.httpMethod = "GET"
                                    urlRequestEjercicios.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                                    urlRequestEjercicios.addValue(token!, forHTTPHeaderField: "token")
                                    let task = urlSession.dataTask(with: urlRequestEjercicios) { (data,response,error) in
                                        guard let data = data else {return}
                                        DispatchQueue.main.async {
                                            do{
                                                let decoder = JSONDecoder()
                                                let sesionesResult = try decoder.decode(SesionesResult.self, from: data)
                                                self.sesiones = sesionesResult.sesiones
                                                
                                            } catch{
                                                print(error.localizedDescription)
                                            }
                                        }
                                        
                                    }
                                    task.resume()
                                }
                                
                            } catch{
                                print(error.localizedDescription)
                            }
                        }
                        
                    }
                    task.resume()
                    
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

extension RutinaActivaViewController: UITableViewDataSource {
    //    MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sesiones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sesionCell = self.sesiones[indexPath.row]
        let idCelda = "celdaSesion"
        let cell = tableView.dequeueReusableCell(withIdentifier: idCelda, for: indexPath)
        
        cell.textLabel?.text = sesionCell.nombre
        return cell
    }
    
}

