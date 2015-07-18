//
//  MapViewController.swift
//  College Profile Builder
//
//  Created by Jack Cable on 7/8/15.
//  Copyright © 2015 Jack Cable. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var textField: UITextField!
    
    var location : String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        chooseLocation(location)
        
//        if let placemark = chooseLocation(location) {
//            let span = MKCoordinateSpanMake(0.1, 0.1)
//            
//            let coordinate = placemark.location.coordinate
//            
//            displayMap(coordinate, span: span, pinTitle: location)
//        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        chooseLocation(textField.text!)
        
        return true
    }
    
    func chooseLocation(location: String) {
        
        print(location)
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(location) { (placemarks, error) -> Void in
            
            if (error != nil) {
                print("Error \(error!)")
                return
            }
            
            if(placemarks == nil) {
                print(error)
            }
            
            if placemarks!.count == 1 {
                let placemark = placemarks![0]
                self.displayMap(placemark.location.coordinate, span: MKCoordinateSpanMake(0.1, 0.1), pinTitle: placemark.name)
                return
            }
            else
            {
                print(placemarks?.count)
            }
            
            let placemarks: [CLPlacemark] = placemarks!
            
            let actionSheet = UIAlertController(title: "Location", message: "Choose location", preferredStyle: .ActionSheet)
            
            for placemark in placemarks {
                
                let name = placemark.name
                print(name)
                let locationAction = UIAlertAction(title: name, style: .Default, handler: { (action) -> Void in
                    self.displayMap(placemark.location.coordinate, span: MKCoordinateSpanMake(0.1, 0.1), pinTitle: placemark.name
                    )
                })
                actionSheet.addAction(locationAction)
                
            }
            self.presentViewController(actionSheet, animated: true, completion: nil)

        }
        
        
    }
    
    func displayMap(center : CLLocationCoordinate2D,
        span: MKCoordinateSpan,
        pinTitle: String) {
            
            let region = MKCoordinateRegionMake(center, span)
            mapView.region = region
            let pin = MKPointAnnotation()
            pin.coordinate = center
            pin.title = pinTitle
            mapView.addAnnotation(pin)
    }
}
