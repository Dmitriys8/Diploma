//
//  AddHouseViewController.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 21/05/2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit
import Firebase

class AddHouseViewController: UIViewController {
    
    var ServiceID: Int?
    
    @IBAction func closeKeyboard(_ sender: Any) {
        patronymicTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
        adressTextField.resignFirstResponder()
    }
    @IBOutlet weak var patronymicTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    
    var numLast: Int?

    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneButtonPressed(_ sender: Any) {
            if adressTextField.text != "" && nameTextField.text != "" && surnameTextField.text != "" && patronymicTextField.text != ""{
                Database.database().reference().child("Houses").child("House\(numLast ?? 0)").child("Adress").setValue(adressTextField.text)
                Database.database().reference().child("Houses").child("House\(numLast ?? 0)").child("ID").setValue(numLast)
                if ServiceID == nil{
                    Database.database().reference().child("Houses").child("House\(numLast ?? 0)").child("ServiceID").setValue(1)
                }else{
                    Database.database().reference().child("Houses").child("House\(numLast ?? 0)").child("ServiceID").setValue(self.ServiceID)
                }
                Database.database().reference().child("Concierge").child("Concierge\(numLast ?? 0)").child("HouseID").setValue(numLast)
                Database.database().reference().child("Concierge").child("Concierge\(numLast ?? 0)").child("Name").setValue(nameTextField.text)
                Database.database().reference().child("Concierge").child("Concierge\(numLast ?? 0)").child("Surname").setValue(surnameTextField.text)
                Database.database().reference().child("Concierge").child("Concierge\(numLast ?? 0)").child("Patronymic").setValue(patronymicTextField.text)
                let VC = HousesTableViewController()
                VC.tableView.reloadData()
                self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
