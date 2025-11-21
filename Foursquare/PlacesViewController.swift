//
//  PlacesViewController.swift
//  Foursquare
//
//  Created by Zeynep Betül Kaya on 21.11.2025.
//

import UIKit

class PlacesViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
    }
    
    @objc func addButtonClicked() {
        
    }

}
