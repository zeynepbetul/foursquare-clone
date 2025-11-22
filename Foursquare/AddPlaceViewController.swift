//
//  AddPlaceViewController.swift
//  Foursquare
//
//  Created by Zeynep Betül Kaya on 22.11.2025.
//

import UIKit

class AddPlaceViewController: UIViewController {

    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var atmosphere: UITextField!
    @IBOutlet weak var selectImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toMapView", sender: nil)
    }
    
}
