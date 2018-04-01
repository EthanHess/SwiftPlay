//
//  OperationQueueViewController.swift
//  Nodetastic
//
//  Created by Ethan Hess on 2/9/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

import UIKit

class OperationQueueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewWillAppear(animated)
        
        let prices = [1.0, 2.0, 11.0, 15.0]
        let names = ["Jason", "Peter", "Diego", "Marie"]
        
        stringFilter(array: names)
        
        numberFilter(array: prices)
        numberMap(array: prices)
        sumUpArray(array: prices)
        
        customQueueExample()
    }
    
    func customQueueExample() {
        
        //Worker queue (concurrent, not serial)
        let ourCustomQueue = DispatchQueue(label: "com.ech.queue", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        let mutateGroup = DispatchGroup()
        
        //
        
        let mutatingCharacter = Character(firstName: "Ethan", lastName: "Hess")
        
        for (idx, name) in namesList().enumerated() {
            ourCustomQueue.async(group: mutateGroup) {
                usleep(UInt32(10_000 * idx))
                mutatingCharacter.changeName(firstName: name.0, lastName: name.1)
                LogDebugging.log("NAME \(mutatingCharacter.name)")
            }
        }
        
        //tasks were asynchronously added to our custom queue and also to the dispatch group simultaneaously
        
        mutateGroup.notify(queue: DispatchQueue.global()) {
            LogDebugging.log("Final name \(mutatingCharacter.name)")
        }
        
        //The above is an example of code that is not thread safe on purpose, to avoid errors regarding thread safety.
        
        //And now for the fix
    }
    
    func namesList() -> [(String, String)] {
        return [("Eva", "Eve"), ("Josh", "Jason"), ("Diego", "Don"), ("Valerie", "Victor"), ("Tyson", "Thiago")]
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
    
    func sumUpArray(array: [Double]) {
        let arrayReduced = array.reduce(0) { (result, price) -> Double in
            return result + price
        }
        LogDebugging.log("--- Sorted Array \(arrayReduced)")
    }
    
    func numberMap(array: [Double]) {
        let mappedPrices = array.map { price -> Double in
            return price * 2
        }
        LogDebugging.log("--- Sorted Array \(mappedPrices)")
    }
    
    func numberFilter(array: [Double]) {
        let affordable = array.filter( { price -> Bool in
            return price < 10
        })
        LogDebugging.log("--- Sorted Array \(affordable)")
    }
    
    func stringFilter(array: [String]) {
        let sortedArray = array.sorted(by: { a, b in
            a > b
        })
        LogDebugging.log("--- Sorted Array \(sortedArray)")
    }
}
