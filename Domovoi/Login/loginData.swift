//
//  loginData.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 24/03/2019.
//  Copyright © 2019 Дмитрий Яковлев. All rights reserved.
//

import Foundation

class loginData {
    var login: String?
    var password: String?
    
    init(login: String?, password: String?){
        self.login = login
        self.password = password
    }
    
    public func getLogin() -> String?{
        return login
    }
    
    public func getPassword() -> String?{
        return password
    }
    
}
