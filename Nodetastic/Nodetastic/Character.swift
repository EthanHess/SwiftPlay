//
//  Character.swift
//  Nodetastic
//
//  Created by Ethan Hess on 3/31/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

import Foundation

open class Character {
    
    private var firstName: String
    private var lastName: String
    
    public init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    open func changeName(firstName: String, lastName: String) {
        //Will need to add delay for Race condition example (to create one on purpose)
        self.firstName = firstName
        self.lastName = lastName
    }
    
    open var name: String {
        return "\(firstName) \(lastName)"
    }
}
