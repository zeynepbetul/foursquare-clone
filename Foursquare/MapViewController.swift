//
//  MapViewController.swift
//  Foursquare
//
//  Created by Zeynep Betül Kaya on 22.11.2025.
//

import UIKit
import MapKit
import CoreLocation
import ParseCore

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveClicked))
        
        let pinGestureRecognizer =  UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        pinGestureRecognizer.minimumPressDuration = 3
        map.addGestureRecognizer(pinGestureRecognizer)
    }
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchedPoint = gestureRecognizer.location(in: self.map)
            let touchedCoordinates = self.map.convert(touchedPoint, toCoordinateFrom: self.map)
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = touchedCoordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            self.map.addAnnotation(annotation)
        }
    }
    
    @objc func saveClicked() {
        let placeModel = PlaceModel.sharedInstance
        let places = PFObject(className: "Places")
        places["name"] = placeModel.placeName
        places["type"] = placeModel.placeType
        places["atmosphere"] = placeModel.atmosphere
        places["latitude"] = placeModel.latitude
        places["longitude"] = placeModel.longitude
        
        if let imageData = placeModel.image?.jpegData(compressionQuality: 0.5) {
            places["image"] = PFFileObject(name: "image.jpg", data: imageData)
        }
        places.saveInBackground { success, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "fromMapVCtoPlacesVC", sender: nil)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        PlaceModel.sharedInstance.latitude = String(locations[0].coordinate.latitude)
        PlaceModel.sharedInstance.longitude = String(locations[0].coordinate.longitude)
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
    }

}
