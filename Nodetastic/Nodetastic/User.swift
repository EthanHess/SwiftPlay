//
//  User.swift
//  Nodetastic
//
//  Created by Ethan Hess on 6/22/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import Foundation

struct UserStruct { //works by copy
    
    var username: String
    
    init(username: String) {
        self.username = username
    }
}

class UserClass { //works by reference

    var username: String = ""

    init(username: String) {
        self.username = username
    }
}
