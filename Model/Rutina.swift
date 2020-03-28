//
//  Routine.swift
//  GymApp
//
//  Created by Eric Martin Gálan on 14/11/2018.
//  Copyright © 2018 Eric Martin Gálan. All rights reserved.
//

import Foundation


struct RutinaResult: Codable {
    var rutina : Rutina?
    var err : MensajeResult?
}

struct RutinasResult: Codable {
    var rutinas : [Rutina]?
    var err : MensajeResult?
}

struct Rutina: Codable {
    var _id : String!
     var nombre : String!
     var usuarioCreador : String?
     var usuario : String?
     var descripcion : String?
     var img : String?
     var estado : Bool?
     var publica : Bool?
     var fechaCreacion : String?
    
    init(_id: String , nombre : String, usuario : String, descripcion : String, usuarioCreador: String, estado: Bool, publica: Bool, fechaCreacion: String) {
        self._id = _id
        self.nombre = nombre
        self.usuarioCreador = usuarioCreador
        self.usuario = usuario
        self.descripcion = descripcion
        self.estado = estado
        self.publica = publica
        self.fechaCreacion = fechaCreacion
    }
}


