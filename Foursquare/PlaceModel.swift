//
//  PlaceModel.swift
//  Foursquare
//
//  Created by Zeynep Betül Kaya on 25.11.2025.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    var placeName: String?
    var placeType: String?
    var atmosphere: String?
    var image: UIImage?
    var latitude: String?
    var longitude: String?
    
    private init() {
        
    }
}
