//
//  LogDebugging.swift
//  Nodetastic
//
//  Created by Ethan Hess on 6/23/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import Foundation

open class LogDebugging {
    
    open class func log(_ message: String, filePath: String = #file, function: String = #function,  line: Int32 = #line) {
        
        _ = logToConsole("", message: message, filePath: filePath, function: function, line: line)
    }
    
    fileprivate class func logToConsole(_ prefix: String, message: String, filePath: String, function: String,  line: Int32) {
        
        let mainThread = Thread.current.isMainThread
        let threadName = mainThread ? "[~MAIN THREAD~]" : "[~BACKGROUND THREAD~]"
        let file: String = (filePath as NSString).lastPathComponent
        
        print("\(threadName)\(prefix)\(file) \(function)[\(line)]: \(message)")
    }
}
