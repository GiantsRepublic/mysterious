//
//  LoginViewController.swift
//  Mysterious
//
//  Created by Jason Wei on 5/30/19.
//  Copyright © 2019 Kaifan Wei. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var pwTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginBtn(_ sender: Any) {
        if pwTextField.text == "Hi77lovesyou!" {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        } else {
            let pwAlert = UIAlertController(title: "警告!", message: "密码输错了哟", preferredStyle: .alert)
            pwAlert.addAction(UIAlertAction(title: "那我再试试", style: .default, handler: nil))
            self.present(pwAlert, animated: true)
        }
    }
    

}