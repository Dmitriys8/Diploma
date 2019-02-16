//
//  OrganisationPageTableViewController.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 20/03/2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit
import Firebase

class ServicePageTableViewController: UITableViewController {

    @IBOutlet weak var NameField: UILabel!
    @IBOutlet weak var AdressField: UILabel!
    @IBAction func editButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "editServiceInfo", sender: nil)
    }
   
    var ModelCell = ServiceCellModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference()
        ref.child("Services").child("Service\(ModelCell.ID ?? 0)").observeSingleEvent(of: .value, with: { (snapshot) in
                self.NameField.text = snapshot.childSnapshot(forPath: "Name").value as? String
                self.AdressField.text = snapshot.childSnapshot(forPath: "Adress").value as? String
            self.tableView.reloadData()
            })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let ref = Database.database().reference()
        ref.child("Services").child("Service\(ModelCell.ID ?? 0)").observeSingleEvent(of: .value, with: { (snapshot) in
            self.NameField.text = snapshot.childSnapshot(forPath: "Name").value as? String
            self.AdressField.text = snapshot.childSnapshot(forPath: "Adress").value as? String
            self.navigationItem.title = snapshot.childSnapshot(forPath: "Name").value as? String
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "editServiceInfo":
            let EditService = segue.destination as? ServiceEditorTableView
            EditService?.ModelCell = self.ModelCell
        
        case "Contacts2":
                let ContactsVC = segue.destination as? ContactsTableViewController
                for i in 1...5{
                    let s = "contact \(i)"
                    ModelCell.Contacts.append(s)
                }
                ContactsVC?.ID = ModelCell.ID
                ContactsVC?.typeOfContacts = "service"
            
        case "showHousesOfService":
                    let HousesVC = segue.destination as? HousesTableViewController
                        HousesVC?.ServiceID = ModelCell.ID
                
        default:
            break
        }
        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
