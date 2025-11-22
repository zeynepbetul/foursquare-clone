//
//  MapViewController.swift
//  Foursquare
//
//  Created by Zeynep Betül Kaya on 22.11.2025.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveClicked))

    }
    
    @objc func saveClicked() {
        
    }

}
