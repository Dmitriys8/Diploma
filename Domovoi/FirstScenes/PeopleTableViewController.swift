//
//  PeopleTableViewController.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 09/04/2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit
import Firebase

class PeopleTableViewController: UITableViewController {

    let cellIdentifier = "PeopleTableViewCell"
    
    var ModelArray = [PeopleCellModel]()
    var ModelCell = PeopleCellModel()
    var HouseID: Int?
    var FamilyID: Int?
    var max: Int = 0
    
    @IBAction func plusButtonPressed(_ sender: Any) {
        Database.database().reference().child("People").observeSingleEvent(of: .value) { (snapshot) in
            for people in snapshot.children{
                let items = (people as! DataSnapshot).value as? [String: Any?]
                if items?["ID"] as! Int > self.max{
                    self.max = items?["ID"] as! Int
                }
            }
            let VC = AddPeopleViewController()
            VC.FamilyID = self.FamilyID
            VC.numLast = self.max + 1
            VC.HouseID = self.HouseID
            self.present(VC, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fillModelArray()
    }
    
    func fillModelArray(){
        ModelArray.removeAll()
        Database.database().reference().child("People").observeSingleEvent(of: .value, with: { snapshot in
            let people = snapshot.children
            for peop in people{
                let itemPeople = (peop as! DataSnapshot).value as? [String: Any]
                let model = PeopleCellModel()
                model.ID = itemPeople?["ID"] as? Int
                model.Name = itemPeople?["Name"] as? String
                model.Surname = itemPeople?["Surname"] as? String
                model.Patronymic = itemPeople?["Patronymic"] as? String
                model.FamilyID = itemPeople?["FamilyID"] as? Int
                model.HouseID = itemPeople?["HouseID"] as? Int
                if self.HouseID == nil{
                    if self.FamilyID == nil{
                        self.ModelArray.append(model)
                    } else {
                        if self.FamilyID == model.FamilyID{
                            self.ModelArray.append(model)
                        }
                    }
                }else{
                    if self.HouseID == model.HouseID{
                        self.ModelArray.append(model)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let model = ModelArray[indexPath.row]
        if let castedCell = cell as? PeopleTableViewCell{
            castedCell.fillCell(with: model)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ModelCell = ModelArray[indexPath.row]
        performSegue(withIdentifier: "PeopSeg", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        guard segue.identifier == "PeopSeg" else {
            return
        }
        let PeoplePageVC = segue.destination as? PeoplePageTableView
        PeoplePageVC?.ModelCell = ModelCell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let cell = self.ModelArray[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить"){
            _, indexPath in
            Database.database().reference().child("People").child("People\(self.ModelArray[indexPath.row].ID ?? 0)").removeValue()
            Database.database().reference().child("Contacts").observeSingleEvent(of: .value, with: { (snapshot) in
                for contact in snapshot.children{
                    let items = (contact as! DataSnapshot).value as? [String: Any?]
                    if items?["ID"] as? Int == cell.ID{
                        Database.database().reference().child("Contacts").child("Contact\(items?["selfID"] as? Int ?? 0)").removeValue()
                    }
                    
                }
            })
            self.ModelArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }
    
}
