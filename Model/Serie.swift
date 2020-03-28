//
//  Series.swift
//  GymApp
//
//  Created by Eric Martin Gálan on 14/11/2018.
//  Copyright © 2018 Eric Martin Gálan. All rights reserved.
//

import Foundation

class Serie: Codable {
    
    private var _repeticiones : Int!
    private var _porcentajeRM : Int?
    private var _ejercicio : String!
    
    init(repeticiones : Int, porcentajeRM : Int, ejercicio : String) {
        self._repeticiones = repeticiones
        self._porcentajeRM = porcentajeRM
        self._ejercicio = ejercicio
    }
    
    init(repeticiones : Int, ejercicio : String) {
        self._repeticiones = repeticiones
        self._ejercicio = ejercicio
    }
}
