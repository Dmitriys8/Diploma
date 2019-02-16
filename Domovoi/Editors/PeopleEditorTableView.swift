//
//  PeopleEditorTableView.swift
//  Domovoi
///Users/dmitriys8/Documents/GitHub/domovoi-ios/Domovoi
//  Created by Дмитрий Яковлев on 11/04/2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit
import Firebase

class PeopleEditorTableView: UITableViewController{
    
    
    @IBOutlet weak var PatronymicField: UITextField!
    @IBOutlet weak var SurnameField: UITextField!
    @IBOutlet weak var NameField: UITextField!
    var ModelCell = PeopleCellModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference()
        ref.child("People").child("People\(ModelCell.ID ?? 0)").observeSingleEvent(of: .value, with: { snapshot in
            self.PatronymicField.text = snapshot.childSnapshot(forPath: "Patronymic").value as? String
            self.NameField.text = snapshot.childSnapshot(forPath: "Name").value as? String
            self.SurnameField.text = snapshot.childSnapshot(forPath: "Surname").value as? String
        })
    }
    
    @IBAction func doneButtonPressed(sender: Any?){
        let ref = Database.database().reference()
        ref.child("People").child("People\(ModelCell.ID ?? 0)").child("Name").setValue(NameField.text)
        ref.child("People").child("People\(ModelCell.ID ?? 0)").child("Patronymic").setValue(PatronymicField.text)
        ref.child("People").child("People\(ModelCell.ID ?? 0)").child("Surname").setValue(SurnameField.text)
        resignFirstResponder()        
    }
}
