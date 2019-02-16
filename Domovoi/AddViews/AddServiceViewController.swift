//
//  AddServiceViewController.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 21/05/2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit
import Firebase

class AddServiceViewController: UIViewController {
    
    var numLast: Int?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        if nameTextField.text != "" && adressTextField.text != ""{
            Database.database().reference().child("Services").child("Service\(numLast ?? 0)").child("Name").setValue(nameTextField.text)
            Database.database().reference().child("Services").child("Service\(numLast ?? 0)").child("Adress").setValue(adressTextField.text)
            Database.database().reference().child("Services").child("Service\(numLast ?? 0)").child("ID").setValue(numLast)
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
