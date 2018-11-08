//
//  AuthService.swift
//  GymApp
//
//  Created by Eric Martin Gálan on 08/11/2018.
//  Copyright © 2018 Eric Martin Gálan. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthService{
    
    private static let _shared = AuthService()
    
    static var shared : AuthService {
        return _shared
    }
    
    func login(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password, completion: {
            (user, error) in
            if let error = (error as NSError?) {
//                Ha habido un error
                if let errorCode = AuthErrorCode(rawValue: error.code){
//                    Chequeamos el codigo de error
                    if errorCode == AuthErrorCode.userNotFound {
//                        Si no existe el usuario lo crea
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil{
//                                Mostrar error si hay problemas al crearlo
                            } else {
                                if user?.uid != nil {
//                                    Login usuario una vez creado
                                    Auth.auth().signIn(withEmail: email,password: password, completion: { (user, error) in
                                        if error != nil{
//                                            Mostramos error usuario de login
                                        } else {
//                                            OK login
                                        }
                                    })
                                }
                            }
                        })
                    } else {
//                        Chequeamos el resto de errores
                    }
                } else {
//                    No se ha podido crear el codigo de error
                }
            } else {
//                Login OK
            }
        })
    }
    
    
    
}
