//
//  FirstViewController.swift
//  Swift-19
//
//  Created by dhruvam patel on 2020-04-06.
//  Copyright © 2020 dhruvam patel. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var patientNameTextField: UITextField!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var recentlyTravelledSwitch: UISwitch!
    @IBOutlet weak var nameError: UILabel!
    
    //MARK: Datasource
    //var waitingList:Array<Patient> = Array()
    var patient:Patient? = nil
    var patientNumber:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Title to be displayed on navigation controller
        self.navigationController?.navigationBar.topItem?.title = "Swift-19"
    
        //Sets maximum date to current day
        self.setDateOneYearBefore()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        patientNameTextField.text = ""
        self.setDateOneYearBefore()
        recentlyTravelledSwitch.isOn = false
    }
    
    //MARK: Actions
    @IBAction func addPatientPressed(_ sender: Any) {
        
        var name:String = patientNameTextField.text!
        
        //Finding age
        let birthYear = Calendar.current.component(.year, from: birthdayPicker.date)
        let currentYear = Calendar.current.component(.year, from: Date())
        let patientAge = currentYear - birthYear
        
        //Finding if travelled recently
        var recentlyTravelled:Bool = false
        if recentlyTravelledSwitch.isOn == true{
            recentlyTravelled = true
        }
        
        //Finding priority
        var priority:Priority = .zero
        if patientAge > 65 && recentlyTravelled == true{
            priority = .three
        } else if patientAge > 65{
            priority = .two
        } else if recentlyTravelled == true{
            priority = .one
        }

        patient = Patient(patientName: name, age: patientAge, recentlyTravelled: recentlyTravelled, priority: priority)
        
        Patient.patients.append(patient!)
    }
    
    @IBAction func resetBtnPressed(_ sender: Any) {
        patientNameTextField.text = ""
        self.setDateOneYearBefore()
        recentlyTravelledSwitch.isOn = false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let screen1B = segue.destination as! WaitingPatient
        
        screen1B.patient = patient
    }
    
    func setDateOneYearBefore(){
        var year = Calendar.current.component(.year, from: Date())
        var month = Calendar.current.component(.month, from: Date())
        var day = Calendar.current.component(.day, from: Date())
        
        var dateComponents = DateComponents()
        dateComponents.year = year - 1
        dateComponents.month = month
        dateComponents.day = day
        
        let userCalendar = Calendar.current // user calendar
        let date = userCalendar.date(from: dateComponents)
        
        birthdayPicker.maximumDate = date
        birthdayPicker.date = date!
    }
}

