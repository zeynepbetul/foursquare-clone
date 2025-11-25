//
//  AddPlaceViewController.swift
//  Foursquare
//
//  Created by Zeynep Betül Kaya on 22.11.2025.
//

import UIKit

class AddPlaceViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var atmosphere: UITextField!
    @IBOutlet weak var selectImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(pickImg))
        selectImage.isUserInteractionEnabled = true
        selectImage.addGestureRecognizer(recognizer)
        
        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(keyboardRecognizer)
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if placeName.text != "" && placeType.text != nil && atmosphere.text != nil {
            if let chosenImage = selectImage.image {
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeName.text!
                placeModel.placeType = placeType.text!
                placeModel.atmosphere = atmosphere.text!
                placeModel.image = chosenImage
                self.performSegue(withIdentifier: "toMapView", sender: nil)
            }
        } else {
                let alert = UIAlertController(title: "Error", message: "Fields cannot be empty", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                present(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc func pickImg() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated:true)
    }
    
}
