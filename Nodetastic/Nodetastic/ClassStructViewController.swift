//
//  ClassStructViewController.swift
//  Nodetastic
//
//  Created by Ethan Hess on 7/2/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import UIKit

class ClassStructViewController: UIViewController {
    
    let nameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        return textField
    }()
    
    let saveButton : UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        return saveButton
    }()
    
    let mutateButton : UIButton = {
        let mutateButton = UIButton()
        mutateButton.setTitle("Mutate", for: .normal)
        return mutateButton
    }()
    
    let toggleSwitch : UISwitch = {
        let tSwitch = UISwitch()
        return tSwitch
    }()
    
    enum UserType {
        case UTClass
        case UTStruct
    }
    
    var userType = UserType.UTClass
    
    var classArray : [UserClass] = []
    var structArray : [UserStruct] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewSetup()
    }
    
    func viewSetup() {
        
        nameTextField.frame = CGRect(x: 50, y: 100, width: self.view.frame.size.width - 100, height: 50)
        nameTextField.delegate = self
        
        saveButton.frame = CGRect(x: 50, y: 150, width: self.view.frame.size.width - 100, height: 50)
        mutateButton.frame = CGRect(x: 50, y: 200, width: self.view.frame.size.width - 100, height: 50)
        
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        mutateButton.addTarget(self, action: #selector(mutate), for: .touchUpInside)
        
        toggleSwitch.center = self.view.center
        toggleSwitch.addTarget(self, action: #selector(toggled), for: .touchUpInside)
        
        view.addSubview(nameTextField)
        view.addSubview(saveButton)
        view.addSubview(mutateButton)
        view.addSubview(toggleSwitch)
        
        view.backgroundColor = UIColor.cyan
    }
    
    @objc func toggled() {
        if userType == .UTClass {
            userType = .UTStruct
        } else {
            userType = .UTClass
        }
    }
    
    @objc func mutate() {
        if userType == .UTClass {
            if classArray.count > 0 { //Changes value
                _ = classArray.map {($0.username = "New Username")}
                LogDebugging.log("NEW CLASS ARRAY --- \(classArray.map {($0.username)})")
            }
        } else {
            for i in 0..<structArray.count { //Doesn't change
                var userStruct = structArray[i]
                userStruct.username = "New Username"
            }
            LogDebugging.log("NEW STRUCT ARRAY --- \(structArray.map {($0.username)})")
        }
    }
    
    @objc func save() {
        
        guard let text = self.nameTextField.text else {
            GlobalFunctions.presentAlert(title: "Please enter some text", text: "", fromVC: self)
            return
        }
        
        switch userType {
        case .UTClass:
            var userC = UserClass(username: text)
            classArray.append(userC)
            LogDebugging.log("\(userC)")
        case .UTStruct:
            var userS = UserStruct(username: text)
            structArray.append(userS)
            LogDebugging.log("\(userS)")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension ClassStructViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
