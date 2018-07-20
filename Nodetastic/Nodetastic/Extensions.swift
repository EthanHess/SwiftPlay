//
//  Extensions.swift
//  Nodetastic
//
//  Created by Ethan Hess on 7/15/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func recurSubviews() -> [UIView] {
        
        var allViews = [UIView]()
        
        func getSubview(view: UIView) { //nested functions = cool :)
            allViews.append(view)
            guard view.subviews.count > 0 else { return; }
            view.subviews.forEach { getSubview(view: $0) }
        }
        
        getSubview(view: self)
        return allViews
    }
}
