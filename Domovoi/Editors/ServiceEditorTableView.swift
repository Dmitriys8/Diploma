//
//  ServiceEditorTableView.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 11/04/2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit
import Firebase

class ServiceEditorTableView: UITableViewController{
    
    @IBOutlet weak var AdressField: UITextField!
    @IBOutlet weak var NameField: UITextField!
    var ModelCell = ServiceCellModel()
    
    @IBAction func doneButtonPressed(_ sender: Any?){
        let ref = Database.database().reference()
        let number = "\(ModelCell.ID ?? 0)"
        ref.child("Services/Service\(number)/Adress").setValue(AdressField.text)
        Database.database().reference().child("Services/Service\(number)/Name").setValue(NameField.text)
        self.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference()
        ref.child("Services").child("Service\(ModelCell.ID ?? 0)").observeSingleEvent(of: .value, with: {snapshot in
            self.AdressField.text = snapshot.childSnapshot(forPath: "Adress").value as? String
            self.NameField.text = snapshot.childSnapshot(forPath: "Name").value as? String
        })
        AdressField.text = ModelCell.Adress
        NameField.text = ModelCell.Name
    }
}

