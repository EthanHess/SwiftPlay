//
//  ViewController.swift
//  Nodetastic
//
//  Created by Ethan Hess on 6/22/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pushButton : UIButton!
    var popButton : UIButton!
    
    var buttonStackView : UIStackView!
    
    var stackOfUsers = Stack<UserStruct>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        buttons()

        stackPushMap()
    }
    
    func buttons() {
        
        let width = self.view.frame.size.width - 20
        
        pushButton = UIButton()
        popButton = UIButton()
        
        pushButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        popButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        pushButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        popButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        pushButton.setTitle("Push", for: .normal)
        popButton.setTitle("Pop", for: .normal)
        
        pushButton.setTitleColor(.white, for: .normal)
        popButton.setTitleColor(.white, for: .normal)
        
        pushButton.backgroundColor = UIColor.darkGray
        popButton.backgroundColor = UIColor.darkGray
        
        pushButton.addTarget(self, action: #selector(push), for: UIControlEvents.touchUpInside)
        popButton.addTarget(self, action: #selector(pop), for: UIControlEvents.touchUpInside)
        
        setUpStackView()
    }
    
    func setUpStackView() {
        
        buttonStackView = UIStackView()
        
        buttonStackView.axis = UILayoutConstraintAxis.vertical
        buttonStackView.distribution = UIStackViewDistribution.equalSpacing
        buttonStackView.alignment = UIStackViewAlignment.center
        buttonStackView.spacing = 20
        
        buttonStackView.addArrangedSubview(popButton)
        buttonStackView.addArrangedSubview(pushButton)
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(buttonStackView)
        
        self.buttonStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.buttonStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        round()
    }
    
    func round() {
        
        for view in self.buttonStackView.subviews {
            if view is UIButton {
                view.layer.cornerRadius = 10
                view.layer.masksToBounds = true
            }
        }
    }
    
    func push() {
        
        if let userToPush = stackOfUsers.top?.next?.value {
            stackOfUsers.push(userToPush)
        } else {
            let userToPush = mockUserArray()[mockUserArray().count - (mockUserArray().count - 1)]
            stackOfUsers.push(userToPush)
        }
        
        logCurrent()
    }
    
    func pop() {
        
        _ = stackOfUsers.pop()
        
        logCurrent()
    }
    
    func logCurrent() {
        LogDebugging.log("CURRENT TOP --PEEK-- \(stackOfUsers.peek())")
    }
    
    //For loop
    
    func stackPush() {
        
        for user in mockUserArray() {
            stackOfUsers.push(user)
        }
        
        LogDebugging.log("USERS \(stackOfUsers)")
        
        topUser()
    }
    
    //Map
    
    func stackPushMap() {
        
        _ = mockUserArray().map({ stackOfUsers.push($0) })
        
        LogDebugging.log("USERS \(stackOfUsers)")
        
        //topUser()
    }
    
    func topUser() {
        
        let index = mockUserArray().count - 1
            
        let currentUser = mockUserArray()[index]
        
        let nextUser = stackOfUsers.pop()
        let oneDeep = stackOfUsers.pop()
        let twoDeep = stackOfUsers.pop()
        
        LogDebugging.log("CURRENT TOP \(currentUser) NEXT TOP \(nextUser) ONE DEEP \(oneDeep) TWO DEEP \(twoDeep)")
        
        stackOfUsers.push(oneDeep!)
        stackOfUsers.push(nextUser!)
        
        LogDebugging.log("Should be back to top \(stackOfUsers.pop())")
    }
    
    func mockUserArray() -> [UserStruct] {
        
        let Jim = UserStruct(name: "Jim", username: "jim@g.com")
        let Joe = UserStruct(name: "Joe", username: "joe@g.com")
        let Jose = UserStruct(name: "Jose", username: "jose@g.com")
        let Julia = UserStruct(name: "Julia", username: "julia@g.com")
        let Megan = UserStruct(name: "Megan", username: "megan@g.com")
    
        return [Jim, Joe, Jose, Julia, Megan]
    }
}

