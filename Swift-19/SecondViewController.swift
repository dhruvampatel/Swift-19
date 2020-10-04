//
//  SecondViewController.swift
//  Swift-19
//
//  Created by dhruvam patel on 2020-04-06.
//  Copyright © 2020 dhruvam patel. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    //MARK: Outlets
    @IBOutlet weak var patientTableView: UITableView!
    
    //MARK: Datasource
    var patients:Array<Patient> = Array()
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Removing data for filling it again
        patients.removeAll()
        
        print(Patient.patients.count)
        //Getting patients with priority 1-3
        addDataToList()
        
        //Sorting according to priority level
        patients.sort(by: { $0.priority.rawValue > $1.priority.rawValue })
        
        //Updating data
        self.patientTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.patientTableView.delegate = self
        self.patientTableView.dataSource = self
        
        //Setting row height
        patientTableView.rowHeight = 105
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "patientCell") as! TestPatientCellTableViewCell
                    
        if (cell == nil) {
            cell = TestPatientCellTableViewCell(
            style: UITableViewCell.CellStyle.default,
            reuseIdentifier: "patientCell")
        }
         
        var priority = patients[indexPath.row].priority.rawValue
        
        cell.patientName.text = patients[indexPath.row].patientName
        cell.patientAge.text = String(patients[indexPath.row].age)
        cell.patientPriority.text = String(priority)
        
        if priority == 3{
            cell.patientName.textColor = UIColor.red
            cell.patientAge.textColor = UIColor.red
            cell.patientPriority.textColor = UIColor.red
            cell.name.textColor = UIColor.red
            cell.age.textColor = UIColor.red
            cell.priority.textColor = UIColor.red
        } else if priority == 2{
            cell.patientName.textColor = UIColor.orange
            cell.patientAge.textColor = UIColor.orange
            cell.patientPriority.textColor = UIColor.orange
            cell.name.textColor = UIColor.orange
            cell.age.textColor = UIColor.orange
            cell.priority.textColor = UIColor.orange
        } else if priority == 1{
            cell.patientName.textColor = UIColor.green
            cell.patientAge.textColor = UIColor.green
            cell.patientPriority.textColor = UIColor.green
            cell.name.textColor = UIColor.green
            cell.age.textColor = UIColor.green
            cell.priority.textColor = UIColor.green
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(self.patients[indexPath.row].patientName)
        
        var alertBox = UIAlertController(title: "Swift-19", message: "Is patient's test completed?", preferredStyle: .alert)
        alertBox.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            action in
            
            var cnt:Int = 0
            var priority:Priority
            var age:Int
            var name:String
            
            for patient in Patient.patients{
                if patient.patientName == self.patients[indexPath.row].patientName && patient.age == self.patients[indexPath.row].age && patient.priority == self.patients[indexPath.row].priority{
                    Patient.patients.remove(at: cnt)
                }
                cnt += 1
            }
            
            //Updating data
            self.patients.removeAll()
            self.addDataToList()
            self.patientTableView.reloadData()
        }))
        alertBox.addAction(UIAlertAction(title: "No", style: .default, handler: {
            action in
            //Redirect the user to the patients waiting for their turn
        }))
        self.present(alertBox, animated: true)
    }
    
    func addDataToList(){
        for patient in Patient.patients{
            if patient.priority.rawValue != 0{
                patients.append(patient)
            }
        }
    }
       
}

