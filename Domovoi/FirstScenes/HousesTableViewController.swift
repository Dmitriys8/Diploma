//
//  HousesTableViewController.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 09/04/2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit
import Firebase

class HousesTableViewController: UITableViewController {
    
    let cellIdentifier = "HouseTableViewCell"
    var max: Int = 0
    var isUserLoggedIn: Bool = false
    
    @IBAction func addButtonPressed(_ sender: Any) {
        Database.database().reference().child("Houses").observeSingleEvent(of: .value) { (snapshot) in
            for house in snapshot.children{
                let items = (house as! DataSnapshot).value as? [String: Any?]
                if items?["ID"] as! Int > self.max{
                    self.max = items?["ID"] as! Int
                }
            }
            let VC = AddHouseViewController()
            VC.numLast = self.max + 1
            VC.ServiceID = self.ServiceID
            self.present(VC, animated: true, completion: nil)
        }        
    }
    
    var ModelArray = [HouseCellModel]()
    var ModelCell = HouseCellModel()
    var ServiceID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isUserLoggedIn{
            let VC = loginViewController()
            self.present(VC, animated: true, completion: nil)
        }
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fillModelArray()
    }
    
    func fillModelArray(){
        ModelArray.removeAll()
        Database.database().reference().child("Houses").observeSingleEvent(of: .value, with: {snapshot in
            self.tabBarItem.title = "Загрузка..."
            for house in snapshot.children {
                let itemHouse = (house as! DataSnapshot).value as? [String: Any]
                let model = HouseCellModel()
                
                model.ID = itemHouse?["ID"] as? Int
                model.Adress = itemHouse?["Adress"] as? String
                model.Consierge.Name = "Consierge name of house \(model.ID ?? 0)"
                model.Consierge.Surname = "Consierge surname of house \(model.ID ?? 0)"
                model.Consierge.Patronymic = "Consierge patronymic of house \(model.ID ?? 0)"
                model.Consierge.ID = itemHouse?["ID"] as? Int
                model.ServiceID = itemHouse?["ServiceID"] as? Int
                if self.ServiceID == nil {
                    self.ModelArray.append(model)
                } else {
                    if model.ServiceID == self.ServiceID {
                    self.ModelArray.append(model)
                    }
                }
            }
            self.tabBarItem.title = "Дома"
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let model = ModelArray[indexPath.row]
        if let castedCell = cell as? HouseTableViewCell{
            castedCell.fillCell(with: model)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ModelCell = ModelArray[indexPath.row]
        performSegue(withIdentifier: "HouSeg", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "HouSeg" else {
            return
        }
        let HousePageVC = segue.destination as? HousePageTableViewController
        HousePageVC?.ModelCell = ModelCell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить") {
            _, indexPath in
            Database.database().reference().child("Houses").child("House\(self.ModelArray[indexPath.row].ID ?? 0)").removeValue()
            Database.database().reference().child("Concierge").child("Concierge\(self.ModelArray[indexPath.row].ID ?? 0)").removeValue()
            self.ModelArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }
}
