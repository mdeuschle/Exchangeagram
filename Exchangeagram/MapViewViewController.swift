//
//  MapViewViewController.swift
//  Exchangeagram
//
//  Created by Jonathan Kilgore on 2/11/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class MapViewViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var currentPhotoData:[FDataSnapshot]!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        for snapshot in currentPhotoData {
            
            if let longitude = snapshot.value["longitude"] {
                print(longitude)
            }
            
            if(snapshot.value["longitude"] != nil && snapshot.value["latitude"] != nil && snapshot.value["location"] != nil) {
                let annotation:MKPointAnnotation = MKPointAnnotation()
                guard
                    let latitude = snapshot.value["latitude"] as? Double,
                    let longitude = snapshot.value["longitude"] as? Double
                    else {
                    return
                }
                
                annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                annotation.title = snapshot.value["caption"] as? String
                mapView.addAnnotation(annotation)
                
                var aggregateLongitude = 0.0
                var aggregateLatitude = 0.0
                var averageLatitude = 0.0
                var averageLongitude = 0.0
                
                
                print(self.mapView.annotations)
                
                for annotation in mapView.annotations {
                    aggregateLatitude = aggregateLatitude + annotation.coordinate.latitude
                    aggregateLongitude = aggregateLongitude + annotation.coordinate.longitude
                }
                
                averageLatitude = aggregateLatitude/Double(self.mapView.annotations.count)
                averageLongitude = aggregateLongitude/Double(self.mapView.annotations.count)
                
                mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(averageLatitude, averageLongitude), MKCoordinateSpanMake(0.05, 0.05)), animated: true)
                
            }

        }
        
    }
    
    //Drops pin for photo locations
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        
        return pin
    }
    
//end of class
}
