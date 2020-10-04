//
//  ThirdViewController.swift
//  Swift-19
//
//  Created by dhruvam patel on 2020-04-06.
//  Copyright © 2020 dhruvam patel. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: Outlets
    @IBOutlet weak var patientTableView: UITableView!
    
    //MARK: Datasource
    var patients:Array<Patient> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.patientTableView.delegate = self
        self.patientTableView.dataSource = self
        
        //Setting row height
        patientTableView.rowHeight = 105
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Removing data to fill it again
        patients.removeAll()
        
        print(Patient.patients.count)
        //Getting patients with priority 1-3
        addDataToList()
        
        //Sorting according to priority level
        patients.sort(by: { $0.patientName < $1.patientName })
        
        //Updating data
        self.patientTableView.reloadData()
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
        
        return cell
    }
    
    func addDataToList(){
        for patient in Patient.patients{
            if patient.priority.rawValue == 0{
                patients.append(patient)
            }
        }
    }
       
}
