//
//  ContactsTableViewController.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 12/04/2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit
import Firebase

class ContactsTableViewController: UITableViewController {
    
    let cellIdentifier = "ContactTableViewCell"
    
    var ID: Int?
    
    var delNum: Int = 0
    
    var typeOfContacts: String?
    
    var ContactsCell = [ContactCellModel]()

    override func viewDidLoad() {
        navigationItem.title = "Контакты"
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FillArray()
    }
    
    func FillArray(){
        ContactsCell.removeAll()
        Database.database().reference().child("Contacts").observeSingleEvent(of: .value, with: { (snapshot) in
            for contact in snapshot.children{
                let items = (contact as! DataSnapshot).value as? [String: Any?]
                let model = ContactCellModel()
                if (items?["type"] as? String) == self.typeOfContacts && (items?["ID"] as? Int) == self.ID{
                    model.selfID = items?["selfID"] as? Int
                    model.title = items?["data"] as? String
                    self.ContactsCell.append(model)
                }
            }
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ContactsCell.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let model = ContactsCell[indexPath.row]
        if let castedCell = cell as? ContactTableViewCell{
            castedCell.fillCell(with: model)
        }
        return cell
    }
    
    @IBAction func plusButtonPressed(){
        let VC = AddContactViewController()
        VC.ID = ID
        VC.typeOfConact = typeOfContacts
        self.present(VC, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить") {
            _, indexPath in
            Database.database().reference().child("Contacts").child("Contact\(self.ContactsCell[indexPath.row].selfID ?? 0)").removeValue()
            self.ContactsCell.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }

}
