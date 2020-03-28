//
//  WeightLiftingData.swift
//  GymApp
//
//  Created by Eric Martin Gálan on 12/11/2018.
//  Copyright © 2018 Eric Martin Gálan. All rights reserved.
//

import Foundation

class WeightLiftingData : Codable{
    
    private var _exercise : String
    private var _weight : Double
    private var _repetitions : Double
    private var _dateData : Date
    
    init(exercise : String,weight : Double, repetitions : Double, dateData : Date) {
        self._exercise = exercise
        self._weight = weight
        self._repetitions = repetitions
        self._dateData = dateData
    }
    
    var exercise : String {
        return _exercise
    }
    
    var weight : Double {
        return _weight
    }
    
    var repetitions : Double {
        return _repetitions
    }
    
    var dateData : Date {
        return _dateData
    }
    
    
    
    
}
