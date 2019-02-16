//
//  ConsiergeTableViewCell.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 14/04/2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit
import Firebase

class ConsiergeTableViewCell: UITableViewCell {

    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var patronimycField: UITextField!
    
    func fillCell(with model: ConsiergeInfo){
        surnameField.text = model.Surname
        nameField.text = model.Name
        patronimycField.text = model.Patronymic
    }
    
    func setValuesToFirebase(with model: ConsiergeInfo){
        model.Name = nameField.text
        model.Surname = surnameField.text
        model.Patronymic = patronimycField.text
        Database.database().reference().child("Concierge").child("Concierge\(model.ID ?? 0)").child("Name").setValue(model.Name)
        Database.database().reference().child("Concierge").child("Concierge\(model.ID ?? 0)").child("Surname").setValue(model.Surname)
        Database.database().reference().child("Concierge").child("Concierge\(model.ID ?? 0)").child("Patronymic").setValue(model.Patronymic)
    }
    
}
