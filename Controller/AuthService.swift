//
//  AuthService.swift
//  GymApp
//
//  Created by Eric Martin Gálan on 08/11/2018.
//  Copyright © 2018 Eric Martin Gálan. All rights reserved.
//

/*import Foundation
import FirebaseAuth

typealias Completion = (_ errorMesage: String?, _ data: AnyObject?) -> Void


class AuthService{
    
    private static let _shared = AuthService()
    
    static var shared : AuthService {
        return _shared
    }
    
    func login(email: String, password: String, onComplete: Completion?){
//        Iniciamos sesion
        Auth.auth().signIn(withEmail: email, password: password, completion: {
            (user, error) in
            if let error = (error as NSError?) {
//                Ha habido un error
                if let errorCode = AuthErrorCode(rawValue: error.code){
//                    Chequeamos el codigo de error
                    if errorCode == AuthErrorCode.userNotFound {
//                        Si no existe el usuario lo crea
                    } else {
//                        Chequeamos el resto de errores
                        self.handleFirebaseError(error: error, onComplete: onComplete)
                    }
                }
            } else {
//                Login OK
                onComplete?(nil,user!)
                
            }
        })
    }
    
    func singIn(email: String, password: String,onComplete: Completion?) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = (error as NSError?){
                //                                Mostrar error si hay problemas al crearlo
                self.handleFirebaseError(error: error, onComplete: onComplete)
            } else {
                if user?.uid != nil {
                    //                                    Login usuario una vez creado
                    Auth.auth().signIn(withEmail: email,password: password, completion: { (user, error) in
                        if let error = (error as NSError?){
                            //                                            Mostramos error usuario de login
                            self.handleFirebaseError(error: error, onComplete: onComplete)
                        } else {
                            //                                            OK login
                            onComplete?(nil,user!.uid as AnyObject)
                        }
                    })
                }
            }
        })
    }
    
    func handleFirebaseError(error: NSError, onComplete: Completion?){
        print(error.debugDescription)
        if let errorCode = AuthErrorCode (rawValue: error.code){
            switch(errorCode){
            case .invalidEmail:
                onComplete?("Email incorrecto",nil)
                break
            case .wrongPassword:
                onComplete?("Contraseña incrrecta",nil)
                break
            case .userDisabled:
                onComplete?("Usuario deshabilitado",nil)
                break
            case .emailAlreadyInUse:
                onComplete?("Email ya usado",nil)
                break
            case .invalidCustomToken:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .customTokenMismatch:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .invalidCredential:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .operationNotAllowed:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .tooManyRequests:
                onComplete?("Demasiados intentos",nil)
                break
            case .userNotFound:
                onComplete?("Usuario no encontrado",nil)
                break
            case .accountExistsWithDifferentCredential:
                onComplete?("Usuario existe con diferentes credenciales",nil)
                break
            case .requiresRecentLogin:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .providerAlreadyLinked:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .noSuchProvider:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .invalidUserToken:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .networkError:
                onComplete?("Error de conexion",nil)
                break
            case .userTokenExpired:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .invalidAPIKey:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .userMismatch:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .credentialAlreadyInUse:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .weakPassword:
                onComplete?("Contraseña demasiado debil",nil)
                break
            case .appNotAuthorized:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .expiredActionCode:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .invalidActionCode:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .invalidMessagePayload:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .invalidSender:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .invalidRecipientEmail:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .missingEmail:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .missingIosBundleID:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .missingAndroidPackageName:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .unauthorizedDomain:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .invalidContinueURI:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .missingContinueURI:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .missingPhoneNumber:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .invalidPhoneNumber:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .missingVerificationCode:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .invalidVerificationCode:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .missingVerificationID:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .invalidVerificationID:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .missingAppCredential:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .invalidAppCredential:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .sessionExpired:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .quotaExceeded:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .missingAppToken:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .notificationNotForwarded:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .appNotVerified:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .captchaCheckFailed:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .webContextAlreadyPresented:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .webContextCancelled:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .appVerificationUserInteractionFailure:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .invalidClientID:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .webNetworkRequestFailed:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .webInternalError:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .keychainError:
                onComplete?(errorCode.rawValue.description,nil)
                break
            case .internalError:
                onComplete?(errorCode.rawValue.description,nil)
                break
            }
            
        }
    }
    
    
    
}*/
