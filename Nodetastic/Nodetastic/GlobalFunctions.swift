//
//  GlobalFunctions.swift
//  Nodetastic
//
//  Created by Ethan Hess on 2/9/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

import UIKit

class GlobalFunctions : NSObject {
    
    //Basic alert

    static func presentAlert(title: String, text: String, fromVC: UIViewController) {
    
        let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
    
        let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
    
        fromVC.present(alertController, animated: true, completion: nil)
    }
    
    static func randomNumber(lowerBound: Int, upperBound: Int) -> Int {
        guard upperBound > lowerBound else {
            assertionFailure("Invalid parameters")
            return 0
        }
        let intToReturn = Int(arc4random_uniform(UInt32(upperBound - lowerBound)) + UInt32(lowerBound))
        return intToReturn
    }
    
    //From Apple docs
    static func minMax(array: [Int]) -> (min: Int, max: Int)? {
        if array.isEmpty { return nil }
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    
    //Inout allows constant parameters to be modified from within
    static func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
}
