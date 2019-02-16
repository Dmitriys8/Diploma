//
//  LaunchViewController.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 23/05/2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit
import Firebase

class LaunchViewController: UIViewController {

    var counter = Counter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.database().reference().child("Houses").observeSingleEvent(of: .value) { (snapshot) in
            for _ in snapshot.children{
                self.counter.HouseCounter += 1
            }
        }
        Database.database().reference().child("People").observeSingleEvent(of: .value) { (snapshot) in
            for _ in snapshot.children{
                self.counter.PeopleCounter += 1
            }
        }
        Database.database().reference().child("Services").observeSingleEvent(of: .value) { (snapshot) in
            for _ in snapshot.children{
                self.counter.ServiceCounter += 1
            }
        }
        Database.database().reference().child("Contacts").observeSingleEvent(of: .value) { (snapshot) in
            for _ in snapshot.children{
                self.counter.ContactsCounter += 1
            }
        }        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
