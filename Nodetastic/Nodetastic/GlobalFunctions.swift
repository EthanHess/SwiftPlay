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
}
