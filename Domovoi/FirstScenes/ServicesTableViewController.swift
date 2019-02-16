//
//  OrganisationsTableViewController.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 14.03.2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit
import Firebase


class ServicesTableViewController: UITableViewController {
    
    let cellIdentifier = "ServiceTableViewCell"

    var ModelArray = [ServiceCellModel]()
    var ModelCell = ServiceCellModel()
    var max: Int = 0
    
    @IBAction func plusButtonPressed(_ sender: Any){
        Database.database().reference().child("Services").observeSingleEvent(of: .value) { (snapshot) in
            for serivce in snapshot.children{
                let items = (serivce as! DataSnapshot).value as? [String: Any?]
                if items?["ID"] as! Int > self.max{
                    self.max = items?["ID"] as! Int
                }
            }
            let VC = AddServiceViewController()
            VC.numLast = self.max + 1
            self.present(VC, animated: true, completion: nil)
        }
    }
    
    
    func refresh(sender: Any?){
        tableView.reloadData()
        refreshControl?.endRefreshing()
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
            self.ModelArray.removeAll()
            Database.database().reference().child("Services").observeSingleEvent(of: .value, with: { snapshot in
            let services = snapshot.children
            for service in services{
                let serviceItems = (service as! DataSnapshot).value as? [String: Any]
                let model = ServiceCellModel()
                model.Name = serviceItems?["Name"] as? String
                model.Adress = serviceItems?["Adress"] as? String
                model.ID = serviceItems?["ID"] as? Int
                self.ModelArray.append(model)
            }
            self.tableView.reloadData()
        })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelArray.count
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить") {
            _, indexPath in
            Database.database().reference().child("Services").child("Service\(self.ModelArray[indexPath.row].ID ?? 0)").removeValue()
            self.ModelArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let model = ModelArray[indexPath.row]
        if let castedCell = cell as? ServiceTableViewCell{
            castedCell.fillCell(with: model)
        }
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ModelCell = ModelArray[indexPath.row]        
        performSegue(withIdentifier: "SerSeg", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        guard segue.identifier == "SerSeg" else{
            return
        }
        let ServicePageVC = segue.destination as? ServicePageTableViewController
        ServicePageVC?.ModelCell = ModelCell
    }
    
}
