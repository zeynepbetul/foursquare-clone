//
//  DetailsViewController.swift
//  Foursquare
//
//  Created by Zeynep Betül Kaya on 22.11.2025.
//

import UIKit
import MapKit
import ParseCore

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var atmosphere: UILabel!
    @IBOutlet weak var placeType: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    var selectedTitle: String?
    var selectedId: String?
    var chosenPlaceID: String?
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()

    }
    func getData() {
        
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: selectedId!)
        query.findObjectsInBackground { objects, error in
            if let error = error {
                
            } else {
                if objects != nil {
                    if objects!.count > 0 {
                        let chosenPlaceObject = objects![0]
                        if let chosenPlaceName = chosenPlaceObject.object(forKey: "name") as? String {
                            self.placeName.text = chosenPlaceName
                        }
                        if let chosenPlaceType = chosenPlaceObject.object(forKey: "type") as? String {
                            self.placeType.text = chosenPlaceType
                        }
                        if let chosenAtmosphere = chosenPlaceObject.object(forKey: "atmosphere") as? String {
                            self.atmosphere.text = chosenAtmosphere
                        }
                        if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? String {
                            if let placeLatitudeDouble = Double(placeLatitude) {
                                self.chosenLatitude = placeLatitudeDouble
                            }
                        }
                        if let placeLongitude = chosenPlaceObject.object(forKey: "longitude") as? String {
                            if let placeLongitudeDouble = Double(placeLongitude) {
                                self.chosenLongitude = placeLongitudeDouble
                            }
                        }
                        if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject {
                            imageData.getDataInBackground { (data, error) in
                                if error == nil {
                                    if data != nil {
                                        self.image.image = UIImage(data: data!)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
