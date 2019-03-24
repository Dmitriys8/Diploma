//
//  TabBarViewController.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 20/05/2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var isUserLoggedIn: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        let VC = loginViewController()
        self.present(VC, animated: true, completion: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
