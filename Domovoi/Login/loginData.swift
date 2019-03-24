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
    
    init(){
        login = "login"
        password = "password"
    }
    
    public func getLogin() -> String?{
        return login
    }
    
    public func getPassword() -> String?{
        return password
    }
    
}
