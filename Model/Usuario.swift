//
//  User.swift
//  GymApp
//
//  Created by Eric Martin Gálan on 12/11/2018.
//  Copyright © 2018 Eric Martin Gálan. All rights reserved.
//
import Foundation


struct UsuarioResult: Codable {
    var usuario : Usuario?
    var err : MensajeResult?
}

struct UsuariosResult: Codable {
    var usuarios : [Usuario]?
    var err : MensajeResult?
}

struct LoginResult: Codable{
    var usuario : Usuario?
    var token : String?
    var err : MensajeResult?
}

struct MensajeResult: Codable{
    var message: String!
    var codigo : Int!
}

struct Usuario: Codable {
    var _id : String
    var nombre : String?
    var email : String?
    var password : String?
    var numero : Int?
    var fechaNacimiento : String?
    var img : String?
    var estado : Bool?
    var publico : Bool?
    var rol : String?
    var entrenador : String?
    var fechaCreacion : String?
    var token : String?
    var rutinaActiva : String?
    
    /*init(id : String,nombre: String, email: String, rol: String, entrenador: String, token: String, numero:Int) {
        self._id = id
        self.nombre = nombre
        self.email = email
        self.rol = rol
        self.entrenador = entrenador
        self.token = token
        self.numero = numero
    }*/
}



