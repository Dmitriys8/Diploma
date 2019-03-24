//
//  loginViewController.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 24/03/2019.
//  Copyright © 2019 Дмитрий Яковлев. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func checkLoginPassword(_ sender: Any) {
        let logData = loginData()
        if loginTextField.text == logData.getLogin() && passwordTextField.text == logData.getPassword(){
            /*self.dismiss(animated: true, completion: nil)*/
            let alert = UIAlertController(title: "Отлично!", message: "Логин и пароль верные!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .destructive, handler: { _ in
                
            }))
            present(alert, animated: true, completion: nil)
            return
        }else {
            let alert = UIAlertController(title: "Ошибка", message: "Логин и пароль не верные!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: { _ in
                
            }))
            present(alert, animated: true, completion: nil)
            return
        }
        
        /*self.dismiss(animated: true, completion: nil)*/
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
