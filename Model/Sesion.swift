//
//  DayExercise.swift
//  GymApp
//
//  Created by Eric Martin Gálan on 14/11/2018.
//  Copyright © 2018 Eric Martin Gálan. All rights reserved.
//

import Foundation

struct SesionResult: Codable {
    var sesion : Sesion?
    var err : MensajeResult?
}

struct SesionesResult: Codable {
    var sesiones : [Sesion]?
    var err : MensajeResult?
}

struct Sesion: Codable {
    var _id : String!
    var nombre : String!
    var descripcion : String?
    var dia : String?
    var orden : Int?
    var rutina : String?
    
    init(_id: String , nombre : String, descripcion : String, dia: String, orden: Int, rutina: String) {
        self._id = _id
        self.nombre = nombre
        self.descripcion = descripcion
        self.dia = dia
        self.orden = orden
        self.rutina = rutina
    }
}
