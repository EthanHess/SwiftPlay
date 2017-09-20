//
//  StackController.swift
//  Nodetastic
//
//  Created by Ethan Hess on 6/22/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import Foundation

class Stack<T> {
    
    var top: Node<T>?
    
    func push(_ value: T) {
        
        let oldTop = top
        
        top = Node(value: value)
        top?.next = oldTop
    }
    
    func pop() -> T? {
        
        let currentTop = top
        top = top?.next
        
        return currentTop?.value
    }
    
    func peek() -> T? {
        return top?.value
    }
    
}
