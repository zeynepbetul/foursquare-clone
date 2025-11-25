//
//  PlacesViewController.swift
//  Foursquare
//
//  Created by Zeynep Betül Kaya on 21.11.2025.
//

import UIKit
import ParseCore

class PlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var placeNames = [String]()
    var placeIds = [String]()
    var chosenTitle: String?
    var chosenId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutClicked))
        
        loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeIds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenTitle = placeNames[indexPath.row]
        chosenId = placeIds[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailsViewController
        destinationVC.selectedTitle = chosenTitle
        destinationVC.selectedId = chosenId
    }
    
    @objc func logoutClicked() {
        PFUser.logOutInBackground { error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
        }
       
    }
    
    @objc func addButtonClicked() {
        self.performSegue(withIdentifier: "toAddVC", sender: nil)
    }
    
    func loadData(){
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { objects, error in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else if let objects = objects {
                self.placeIds.removeAll(keepingCapacity: false)
                self.placeNames.removeAll(keepingCapacity: false)
                for object in objects {
                    if let placeName = object.object(forKey: "name") as? String {
                        if let placeID = object.objectId {
                            self.placeNames.append(placeName)
                            self.placeIds.append(placeID)
                        }
                    }
                }
                self.table.reloadData()
            }
        }
    }

}
