//
//  ThreadSafety.swift
//  Nodetastic
//
//  Created by Ethan Hess on 6/9/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

import UIKit

class ThreadSafety: NSObject {

}

//Thread safe, no chance of object being modified by two different threads

class ThreadSafeCharacter : Character {
    
    let isolationQueue = DispatchQueue(label: "com.ech.isolation", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
    
    override func changeName(firstName: String, lastName: String) {
        isolationQueue.async(group: nil, qos: .default, flags: .barrier) {
            super.changeName(firstName: firstName, lastName: lastName)
        }
    }
    
    override var name: String {
        return isolationQueue.sync {
            return super.name
        }
    }
}

//Operation

class OperationController {
    
    var operation = BlockOperation {
        LogDebugging.log("ONE")
    }
    
    func secondBlock() {
        operation.addExecutionBlock {
            LogDebugging.log("TWO")
        }
        operation.start()
    }
}

class ImageTransformOperation: Operation {
    var inputImage : UIImage?
    var outputImage : UIImage?
    
    override func main() {
        
    }
}

//Async operation

open class AsyncOperation: Operation {
    //State enum
    public enum State: String {
        case ready, executing, finished
        
        fileprivate var keyPath : String {
            return "is" + rawValue.capitalized
        }
    }
    
    //State prop
    public var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
}

extension AsyncOperation {
    
    override open var isReady : Bool {
        return super.isReady && state == .ready
    }
    
    override open var isExecuting : Bool {
        return state == .executing
    }
    
    override open var isFinished : Bool {
        return state == .finished
    }
    
    override open var isAsynchronous : Bool {
        return true
    }
    
    override open func start() {
        if isCancelled {
            state = .finished
            return
        }
        
        main()
        state = .executing
    }
    
    override open func cancel() {
        super.cancel()
        state = .finished
    }
}

//End
