//
//  Exercise.swift
//  GymApp
//
//  Created by Eric Martin Gálan on 14/11/2018.
//  Copyright © 2018 Eric Martin Gálan. All rights reserved.
//

import Foundation

struct EjercicioResult: Codable {
    var ejercicio : Ejercicio?
    var err : MensajeResult?
}

struct EjerciciosResult: Codable {
    var ejericios : [Ejercicio]?
    var err : MensajeResult?
}

struct Ejercicio: Codable {
    var _id : String!
    var nombre: String!
    var descripcion: String!
    var descanso : Int!
    var comentarioEntrenador: String?
    var img : String?
    var orden: Int?
    var publico: Bool!
    var sesion: String?
    var musculo: String?
    
    init(_id: String , nombre : String, descanso : Int, orden: Int, publico: Bool, descripcion: String) {
        self._id = _id
        self.nombre = nombre
        self.descanso = descanso
        self.descripcion = descripcion
        self.orden = orden
        self.publico = publico
    }
}
