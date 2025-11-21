//
//  ViewController.swift
//  Foursquare
//
//  Created by Zeynep Betül Kaya on 20.11.2025.
//

import UIKit
import ParseCore

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func signIn(_ sender: Any) {
    }
    
    @IBAction func signUp(_ sender: Any) {
        if username.text != "" && password.text != "" {
            let user = PFUser()
            user.username = username.text!
            user.password = password.text!
            user.signUpInBackground { success, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    // performsegue
                }
            }
        } else {
            makeAlert(title: "Error", message: "Username or Password cannot be empty")
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

