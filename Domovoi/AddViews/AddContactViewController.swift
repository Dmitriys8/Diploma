//
//  AddContactViewController.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 21/05/2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit
import Firebase

class AddContactViewController: UIViewController {
    
    var typeOfConact: String?
    var ID: Int?
    var max: Int = 0
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        Database.database().reference().child("Contacts").observeSingleEvent(of: .value) { (snapshot) in
            for contact in snapshot.children{
                let items = (contact as! DataSnapshot).value as? [String: Any?]
                if items?["selfID"] as! Int > self.max{
                    self.max = items?["selfID"] as! Int
                }
            }
            self.max += 1
            Database.database().reference().child("Contacts").child("Contact\(self.max)").child("data").setValue(self.textField.text)
            Database.database().reference().child("Contacts").child("Contact\(self.max)").child("ID").setValue(self.ID)
            Database.database().reference().child("Contacts").child("Contact\(self.max)").child("type").setValue(self.typeOfConact)
            Database.database().reference().child("Contacts").child("Contact\(self.max)").child("selfID").setValue(self.max)
            let VC = ContactsTableViewController()
            VC.tableView.reloadData()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
