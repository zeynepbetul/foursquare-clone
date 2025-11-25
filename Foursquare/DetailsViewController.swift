//
//  DetailsViewController.swift
//  Foursquare
//
//  Created by Zeynep Betül Kaya on 22.11.2025.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var atmosphere: UILabel!
    @IBOutlet weak var placeType: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    var selectedTitle: String?
    var selectedId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
