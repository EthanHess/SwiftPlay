//
//  Node.swift
//  Nodetastic
//
//  Created by Ethan Hess on 6/22/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import Foundation

class Node<T> {
    
    let value: T
    var next: Node?
    
    init(value: T) {
        self.value = value
    }
}
