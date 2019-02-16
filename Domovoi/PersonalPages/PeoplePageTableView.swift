//
//  UserPageTableView.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 20/03/2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit
import Firebase

class PeoplePageTableView: UITableViewController {

    @IBOutlet weak var SurnameField: UILabel!
    @IBOutlet weak var NameField: UILabel!
    @IBAction func editButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "editPeopleData", sender: nil)
    }
    @IBOutlet weak var PatronymicField: UILabel!
    
    var ModelCell = PeopleCellModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Пользователь"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Пользователь"
        let ref = Database.database().reference()
        ref.child("People").child("People\(ModelCell.ID ?? 0)").observeSingleEvent(of: .value, with:
            { snapshot in
                self.NameField.text = snapshot.childSnapshot(forPath: "Name").value as? String
                self.SurnameField.text = snapshot.childSnapshot(forPath: "Surname").value as? String
                self.PatronymicField.text = snapshot.childSnapshot(forPath: "Patronymic").value as? String
                self.tableView.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "editPeopleData":
            let EditVC = segue.destination as? PeopleEditorTableView
            EditVC?.ModelCell = ModelCell
        case "Contacts":
            let ContactVC = segue.destination as? ContactsTableViewController
            ContactVC?.ID = ModelCell.ID
            ContactVC?.typeOfContacts = "people"
        case "FamilySegue":
            let VC = segue.destination as? PeopleTableViewController
            VC?.navigationItem.title = "Семья"
            VC?.FamilyID = ModelCell.FamilyID
        default:
            break
        }
        if segue.identifier == "editPeopleData"{
            
        } else {
            if segue.identifier == "Contacts"{
                
            } else {
                return
            }
        }
        
    }
}
