//
//  LoginViewController.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 21/02/2019.
//  Copyright © 2019 Дмитрий Яковлев. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        enterButton.isEnabled = false
        

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var enterButton: UIButton!
    
    /*
    @IBAction func enterButtonPressed(_ sender: Any) {
         performSegue(withIdentifier: "loginSeg", sender: nil)
    }*/
    
    @IBAction func endEnterPassword(_ sender: Any) {
        enterButton.isEnabled = true;
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let VC = segue.destination as? TabBarViewController
        VC?.viewDidLoad()
        return
    }

}
