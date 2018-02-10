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
}
