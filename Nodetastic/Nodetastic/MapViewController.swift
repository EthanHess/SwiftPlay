//
//  MapViewController.swift
//  Nodetastic
//
//  Created by Ethan Hess on 6/25/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var KVOCon : KVOController?
    
    var mapView : MKMapView!
    
    dynamic var annotationsArray : [MKPointAnnotation] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpMapView()
        
        setUpObservationWithKeyPath(keyPath: "annotationsArray")
    }
    
    func setUpObservationWithKeyPath(keyPath: String) {
        
        KVOCon = KVOController.beginObserving(theObject: self, keyPath: keyPath, callBack: { 
            LogDebugging.log("KVO! \(self.annotationsArray.count)")
        })
    }
    
    func setUpMapView() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        
        mapView = MKMapView(frame: self.view.bounds)
        mapView.delegate = self
        mapView.addGestureRecognizer(tap)
        self.view.addSubview(mapView)
    }
    
    func handleTap(sender: UIGestureRecognizer) {
        
        let point = sender.location(in: self.mapView)
        let theCoord = self.mapView.convert(point, toCoordinateFrom: self.mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = theCoord
        
        //Add to array here
        annotationsArray.append(annotation)
        
        self.mapView.addAnnotation(annotation)
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

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        
    }
}
