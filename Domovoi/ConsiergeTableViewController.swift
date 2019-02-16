//
//  ConsiergeTableViewController.swift
//  
//
//  Created by Дмитрий Яковлев on 11/04/2018.
//

import UIKit
import Firebase

class ConsiergeTableViewController: UITableViewController {

    let cellIdentifier = "ContactTableViewCell"
    let cellIdentifier2 = "ConsiergeTableViewCell"
    
    var ModelCell = ConsiergeInfo()
    
    var ContactsCell = [ContactCellModel]()
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as? ConsiergeTableViewCell
        cell?.setValuesToFirebase(with: ModelCell)
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2)
//        if let castedCell = cell as? ConsiergeTableViewCell{
//            castedCell.setValuesToFirebase(with: ModelCell)
//        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //fillArray()
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.register(UINib.init(nibName: cellIdentifier2, bundle: nil), forCellReuseIdentifier: cellIdentifier2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fillArray()
    }
    
    func fillArray(){
        Database.database().reference().child("Concierge").child("Concierge\(ModelCell.ID ?? 0)").observeSingleEvent(of: .value, with: { (snapshot) in
                self.navigationItem.title = "Loading..."
                self.ModelCell.Name = snapshot.childSnapshot(forPath: "Name").value as? String
                self.ModelCell.Surname = snapshot.childSnapshot(forPath: "Surname").value as? String
                self.ModelCell.Patronymic = snapshot.childSnapshot(forPath: "Patronymic").value as? String
                self.navigationItem.title = ""
                self.tableView.reloadData()
            })
            self.ModelCell.Contacts.removeAll()
        Database.database().reference().child("Contacts").observeSingleEvent(of: .value, with: { snapshot in
            self.navigationItem.title = "Loading..."
            for contact in snapshot.children{
                let items = (contact as! DataSnapshot).value as? [String: Any?]
                if (items?["type"] as? String) == "concierge" && ((items?["ID"] as? Int) == self.ModelCell.ID){
                    self.ModelCell.Contacts.append(items?["data"] as? String)
                }
            }
            self.ContactsCell.removeAll()
            if self.ModelCell.Contacts.count != 0{
                for i in 1...self.ModelCell.Contacts.count{
                    let model = ContactCellModel()
                    model.title = self.ModelCell.Contacts[i - 1]
                    self.ContactsCell.append(model)
                }
            }
            self.navigationItem.title = ""
            self.tableView.reloadData()
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return ContactsCell.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2, for: indexPath)
            let model = ModelCell
            if let castedCell = cell as? ConsiergeTableViewCell {
                castedCell.fillCell(with: model)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            let model = ContactsCell[indexPath.row]
            if let castedCell = cell as? ContactTableViewCell{
                    castedCell.fillCell(with: model)
            }
        return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Консьерж"
        } else {
            return "Контакты"
        }
    }

   

}
