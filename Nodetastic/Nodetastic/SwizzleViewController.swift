//
//  SwizzleViewController.swift
//  Nodetastic
//
//  Created by Ethan Hess on 7/2/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import UIKit

class SwizzleViewController: UIViewController {
    
    lazy var swizView : SwizzleView = {
        
        let width = self.view.frame.size.width - 20
        let yCoord = (self.view.frame.size.height / 2) - (width / 2)
        let frame = CGRect(x: 10, y: yCoord, width: width, height: width)
        
        let theView = SwizzleView(frame: frame)
        
        return theView
    }()
    
    override func loadView() {
        super.loadView()
        
        self.nonCustomSwizzling(self.superclass as! UIViewController.Type)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //self.nonCustomSwizzling(self.superclass as! UIViewController.Type)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        swizView.backgroundColor = UIColor.green
        swizView.layer.cornerRadius = swizView.frame.size.width / 2
        swizView.layer.masksToBounds = true
        //swizView.swizzleMethods(origSelector: Selector(swizView.init()), withSelector: Selector(("myInit")))
        
        self.view.addSubview(swizView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private let nonCustomSwizzling: (UIViewController.Type) -> () = { viewController in
        
        let originalSelector = #selector(viewController.viewWillAppear(_:))
        let swizzledSelector = #selector((viewController.myViewWillAppear))

        let originalMethod = class_getInstanceMethod(viewController, originalSelector)
        let swizzledMethod = class_getInstanceMethod(viewController, swizzledSelector)
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController {
    
    func myViewWillAppear() {
        LogDebugging.log("Non Custom Swizzling!")
    }
}
