//
//  AddPeopleViewController.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 21/05/2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit
import Firebase

class AddPeopleViewController: UIViewController {
    
    var numLast: Int?
    let cellIdentifier = "ContactTableViewCell"
    var HouseID: Int?
    var FamilyID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any){
        if surnameTextField.text != "" && patronymicTextField.text != "" && nameTextField.text != ""{
            Database.database().reference().child("People").child("People\(numLast ?? 0)").child("Name").setValue(nameTextField.text)
            Database.database().reference().child("People").child("People\(numLast ?? 0)").child("Surname").setValue(surnameTextField.text)
            Database.database().reference().child("People").child("People\(numLast ?? 0)").child("Patronymic").setValue(patronymicTextField.text)
            Database.database().reference().child("People").child("People\(numLast ?? 0)").child("ID").setValue(numLast)
            if HouseID == nil{
                Database.database().reference().child("People").child("People\(numLast ?? 0)").child("HouseID").setValue(1)
            }else{
                Database.database().reference().child("People").child("People\(numLast ?? 0)").child("HouseID").setValue(HouseID)
            }
            if FamilyID == nil{
                Database.database().reference().child("People").child("People\(numLast ?? 0)").child("FamilyID").setValue(1)
            }else{
                Database.database().reference().child("People").child("People\(numLast ?? 0)").child("FamilyID").setValue(self.FamilyID)
            }
            let VC = PeopleTableViewController()
            VC.tableView.reloadData()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var patronymicTextField: UITextField!
    
    @IBAction func closeKeyboard(_ sender: Any) {
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
        patronymicTextField.resignFirstResponder()
    }
    
}
