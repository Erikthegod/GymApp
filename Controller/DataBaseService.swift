//
//  DataBaseService.swift
//  GymApp
//
//  Created by Eric Martin Gálan on 09/11/2018.
//  Copyright © 2018 Eric Martin Gálan. All rights reserved.
//

/*import Foundation
import FirebaseFirestore

class DataBaseService {
    
    private static let _shared = DataBaseService()
    
    static var shared : DataBaseService {
        return _shared
    }
    
    let connectionDB = Firestore.firestore()
    
    var usersCollectionRef: CollectionReference {
        return connectionDB.collection("users")
    }
    
    var rutinasCollectionRef: CollectionReference {
        return connectionDB.collection("rutinas")
    }
    
    var indexIdUserEmail: CollectionReference {
        return connectionDB.collection("idUserEmail")
    }
    
    
    func saveIndexIdUserEmail(idUser:String, email:String)  {
        let docDataUser: [String: Any] = [
                "email": email as Any,
                "idUser": idUser as Any,
        ]
        self.indexIdUserEmail.document().setData(docDataUser)
        {
            err in if let err = err{
                print("\(err)")
            } else {
                print("Document add")
            }
        }
    }
    
    func saveUserProfile(uid: String,email: String, name: String, telephone: Int, birthday: Date, height: Int, weight: Int, personalTrainner: Bool){
        let profile =  Profile (email: email, name: name, telephone: telephone, birthday: birthday, historicalMeasures: HistoricalMeasures(height: Double(height), weight: Double(weight), dateProfile: .init()), personalTrainner : personalTrainner)
        let user = User (idUser: uid, profile: profile)
        
        let docDataUser: [String: Any] = [
            "profile": [
                "email": user.profile.email as Any,
                "name": user.profile.name as Any,
                "telephone": user.profile.telephone as Any,
                "birthday": user.profile.birthday as Any,
                "personalTrainner": user.profile.personalTrainner as Any
            ]
        ]
        self.usersCollectionRef.document(user.idUser).setData(docDataUser)
        {
            err in if let err = err{
                print("\(err)")
            } else {
                print("Document add")
                self.saveIndexIdUserEmail(idUser: user.idUser, email: (user.profile.email))
                self.saveHistoricMeasures(idUser: user.idUser, measure: profile.historicalMeasures)
            }
        }
    }
    
    func saveHistoricMeasures(idUser: String,measure: HistoricalMeasures) {
        let docDataUser: [String: Any] = [
            "height": measure.height as Any,
            "weight": measure.weight as Any,
            "measureDate": measure.dateProfile as Any,
        ]
        self.usersCollectionRef.document(idUser).collection("historicalMeasures").document().setData(docDataUser)
        {
            err in if let err = err{
                print("\(err)")
            } else {
                print("Document add")
            }
        }
    }
    
    func loadClientUser(idUser : String) {
        let docRef = self.usersCollectionRef.document(idUser)
        docRef.getDocument { (document, error) in
            if let user = document.flatMap({
                $0.data().compactMap({ (data) in
                    return User(dictionary: (document?.data())!)
                })
            }) {
                print("City: \(user)")
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
    func isPersonalTrainner(idUser: String) -> Bool {
        return true
    }
    
    
}
*/
