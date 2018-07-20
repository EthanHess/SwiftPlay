//
//  SceneKitViewController.swift
//  Nodetastic
//
//  Created by Ethan Hess on 3/11/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

import UIKit
import SceneKit

class SceneKitViewController: UIViewController {
    
    var scnView = SCNView()
    var scnScene = SCNScene()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scnView = SCNView(frame: view.frame)
        view.addSubview(scnView)
        
        scnAmbient()
    }
    
    func scnAmbient() {
        
        //camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scnScene.rootNode.addChildNode(cameraNode)
        
        // camera postion
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        // light
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLight.LightType.omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scnScene.rootNode.addChildNode(lightNode)
        
        // ambient light added to scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scnScene.rootNode.addChildNode(ambientLightNode)
    
        scnView.allowsCameraControl = true
        scnView.showsStatistics = true
        
        scnView.backgroundColor = UIColor.black
        scnView.scene = scnScene
        
        generetateRandomNumberArray()
    }
    
    func generetateRandomNumberArray() {
        let number = GlobalFunctions.randomNumber(lowerBound: 10, upperBound: 100)
        generateRandomPoints(arrayCount: number)
    }
    
    func generateRandomPoints(arrayCount: Int) {
        
        var pointArray : [CGPoint] = []
        for i in 0..<arrayCount {
            
            LogDebugging.log("\(i)")
            
            //Will need to adjust for screen size
            let xCoord = GlobalFunctions.randomNumber(lowerBound: 0, upperBound: 375)
            let yCoord = GlobalFunctions.randomNumber(lowerBound: 0, upperBound: 600)
            
            let point = CGPoint(x: xCoord, y: yCoord)
            pointArray.append(point)
        }
        
        generateRandomShapesAndPlaceOnScreen(pointArray: pointArray)
    }
    
    func generateRandomShapesAndPlaceOnScreen(pointArray: [CGPoint]) {
        
        for i in 0..<pointArray.count {
            LogDebugging.log("\(i)")
            let xCoord = pointArray[i].x
            let yCoord = pointArray[i].y
            let sphere = SCNSphere(radius: CGFloat(GlobalFunctions.randomNumber(lowerBound: 5, upperBound: 50)) / 10)
            let planetNode = SCNNode(geometry: sphere)
            planetNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
            planetNode.position = SCNVector3(Float(xCoord), Float(yCoord), 10)
            scnScene.rootNode.addChildNode(planetNode)
            
            //let quad = SCNVector4Make(1, 2, 3, 4)
        }
        
        LogDebugging.log("SCN CHILDREN --- \(scnScene.rootNode.childNodes)")
    }
    
    fileprivate func tapForNode(node: SCNNode) {
         //We'll just do a SCNHitTestResult for now, no need for this?
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let theTouch = touches.first!
        if theTouch.view == self.scnView {
            let location : CGPoint = theTouch.location(in: self.scnView)
            if let resultLocation = self.scnView.hitTest(location, options: nil).first {
                LogDebugging.log("Result Node \(resultLocation.node)")
                goToNetworking()
            }
        }
    }
    
    //Todo, generate random shape
    func scnShapeTypeArray() -> [Any] {
        return [SCNBox(), SCNSphere(), SCNPyramid()]
    }
    
    fileprivate func goToNetworking() {
        let networkingVC = CustomServerClientViewController()
        self.navigationController?.pushViewController(networkingVC, animated: true)
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
