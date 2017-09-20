//
//  KVOController.swift
//  Nodetastic
//
//  Created by Ethan Hess on 7/1/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import UIKit

class KVOController: NSObject {

    //static let singleton = KVOController()
    
    private let keyPath: String
    private let observationCallback: ()-> Void
    private let objectBeingObserved: NSObject
    
    private init(objectBeingObserved: NSObject, keyPath: String, observationCallback: @escaping ()-> Void) {
        self.objectBeingObserved = objectBeingObserved
        self.keyPath = keyPath
        self.observationCallback = observationCallback
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        observationCallback()
        
        LogDebugging.log("KVO --\(keyPath) -- \(object)")
    }
    
    class func beginObserving(theObject: NSObject, keyPath: String, callBack: @escaping ()-> Void) -> KVOController {
        
        let KVO = KVOController(objectBeingObserved: theObject, keyPath: keyPath, observationCallback: callBack)
        
        theObject.addObserver(KVO, forKeyPath: keyPath, options: .new, context: nil)
        
        return KVO
    }
    
    deinit {
        objectBeingObserved.removeObserver(self, forKeyPath: keyPath)
    }
}
