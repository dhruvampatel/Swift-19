//
//  Patient.swift
//  Swift-19
//
//  Created by dhruvam patel on 2020-04-06.
//  Copyright © 2020 dhruvam patel. All rights reserved.
//

import Foundation

enum Priority: Int{
  case zero = 0,one,two,three
 }

class Patient{
    var patientName:String = ""
    var age:Int = 0
    var recentlyTravelled:Bool = false
    var priority:Priority = .zero
    static var patients:Array<Patient> = Array()
    
    init(patientName: String, age: Int, recentlyTravelled: Bool, priority: Priority) {
        self.patientName = patientName
        self.age = age
        self.recentlyTravelled = recentlyTravelled
        self.priority = priority
    }
}
