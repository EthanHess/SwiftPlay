//
//  CustomServerClientViewController.swift
//  Nodetastic
//
//  Created by Ethan Hess on 6/9/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

import UIKit
import Foundation

class CustomServerClientViewController: UIViewController {
    
    let cellDQID = "cell"
    
    var tableView : UITableView = {
        let TV = UITableView()
        return TV
    }()
    
    var myFeed : MyFeed?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: 10, y: 100, width: self.view.frame.size.width - 20, height: self.view.frame.size.height - 150)
        
        tableView.frame = frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellDQID)
        self.view.addSubview(tableView)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    fileprivate func fetchData() {
        
        let baseURL = "http://localhost:6069"
        let feedURL = "/feedObjects"
        
        let stringToFetch = "\(baseURL)\(feedURL))"
        
        NetworkingService.sharedManager.fetchDataWithGenericType(urlString: stringToFetch) { (feed: MyFeed) in
            self.myFeed = feed
            self.refresh()
        }
    }
    
    fileprivate func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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

extension CustomServerClientViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let theCell = tableView.dequeueReusableCell(withIdentifier: cellDQID, for: indexPath)
        theCell.textLabel?.text = myFeed?.posts[indexPath.row].name
        return theCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFeed?.posts.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        LogDebugging.log("\(String(describing: myFeed?.posts[indexPath.row]))")
        
        //Go to detail
    }
}

struct NetworkingService {
    
    //In some cases class functions may be better than evil singletons ;)
    
    static let sharedManager = NetworkingService()
    
    //Escaping means closure can be invoked after function returns
    
    func fetchDataWithGenericType<T: Decodable>(urlString: String, completion: @escaping (T) ->()) {
        
        guard let fetchURL = URL(string: urlString) else {
            LogDebugging.log("NO URL")
            return
        }
        
        URLSession.shared.dataTask(with: fetchURL) { (data, response, error) in
            
            if let tError = error {
                LogDebugging.log(tError.localizedDescription)
                return
            }
            guard let tData = data else {
                LogDebugging.log("NO DATA")
                return
            }
            
            do {
                let myFeed = try JSONDecoder().decode(T.self, from: tData)
                DispatchQueue.main.async {
                    completion(myFeed)
                }
            } catch let jsonError {
                LogDebugging.log(jsonError.localizedDescription)
            }
        }.resume()
    }
}

//Move to seperate swift file

//Decodable = A type that can decode itself from an external representation (Apple)

struct MyFeed : Decodable {
    let posts: [Post]
}

struct Post : Decodable {
    let id : Int
    let name : String
    let videoLink : String
    let imageURL : String
}

