//
//  SwizzleView.swift
//  Nodetastic
//
//  Created by Ethan Hess on 7/4/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import UIKit

class SwizzleView: UIView {
    
    private let swizzling: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
        let originalMethod = class_getInstanceMethod(forClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func myInitFrame(frame: CGRect) {
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
}
