//
//  Profile.swift
//  GymApp
//
//  Created by Eric Martin Gálan on 12/11/2018.
//  Copyright © 2018 Eric Martin Gálan. All rights reserved.
//

import Foundation

struct Profile {
    
    private let _name : String?
    private let _email : String?
    private var _telephone : Int?
    private var _birthday : Date?
    private var _historicalMeasures : HistoricalMeasures?
    private let _personalTrainner : Bool
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "email": email,
            "telephone": telephone,
            "personalTrainer": personalTrainner,
        ]
    }
    
    init(name: String,email: String,telephone: Int, personalTrainer: Bool) {
        self._name = name
        self._email = email
        self._telephone = telephone
        self._personalTrainner = personalTrainer
    }
    
    init(email: String, name: String, telephone: Int, birthday: Date, historicalMeasures: HistoricalMeasures, personalTrainner : Bool) {
        self._name = name
        self._email = email
        self._telephone = telephone
        self._personalTrainner = personalTrainner
        self._birthday = birthday
        self._historicalMeasures = historicalMeasures
        
    }
    
    var historicalMeasures : HistoricalMeasures {
        return _historicalMeasures!
    }
    
    var name : String {
        return _name!
    }
    
    var telephone : Int {
        return _telephone!
    }
    
    var birthday : Date {
        return _birthday!
    }
    
    var email : String {
        return _email!
    }
    
    var personalTrainner : Bool {
        return _personalTrainner
    }

    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let email = dictionary["email"] as? String,
            let telephone = dictionary["telephone"] as? Int
            else { return nil }
        self.init(name: name,email: email,telephone: telephone,personalTrainer: false)
    }
}


struct HistoricalMeasures {
    private var _height : Double
    private var _weight : Double
    private var _dateProfile : Date
    
    init(height: Double, weight:Double,dateProfile:Date) {
        self._height = height
        self._weight = weight
        self._dateProfile = dateProfile
    }
    
    var height : Double{
        return _height
    }
    
    var weight : Double{
        return _weight
    }
    
    var dateProfile : Date{
        return _dateProfile
    }
}
