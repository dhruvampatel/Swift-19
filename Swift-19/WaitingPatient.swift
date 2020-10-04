//
//  WaitingPatient.swift
//  Swift-19
//
//  Created by dhruvam patel on 2020-04-06.
//  Copyright © 2020 dhruvam patel. All rights reserved.
//

import UIKit

class WaitingPatient: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var patientAge: UILabel!
    @IBOutlet weak var patientRecentlyTravelled: UILabel!
    @IBOutlet weak var patientPriority: UILabel!
    @IBOutlet weak var patientNumber: UILabel!
    
    
    //MARK: Datasource
    var patient:Patient? = nil
    var waitingList:Array<Patient> = Array()
    
    //MARK: Variables
    var travelled:String = "No"
    var numberInList:Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Getting data
        waitingList = Patient.patients
        
        //Sorting according to priority level
        waitingList.sort(by: { $0.priority.rawValue > $1.priority.rawValue })

        for patient in waitingList{
            if patient.patientName == self.patient?.patientName && patient.age == self.patient?.age && patient.priority == self.patient?.priority{
                break
            }
            numberInList += 1
        }
        
        patientName.text = patient?.patientName
        patientAge.text = String(patient!.age)
        if patient?.recentlyTravelled == true{
            travelled = "Yes"
        }
        patientRecentlyTravelled.text = travelled
        patientPriority.text = String(patient!.priority.rawValue)
        
        if patient?.priority.rawValue == 0{
            patientNumber.text = "No test required"
        } else{
            patientNumber.text = String(numberInList)
        }
        
    }
    
}
