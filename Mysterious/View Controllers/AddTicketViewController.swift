//
//  AddTicketViewController.swift
//  Mysterious
//
//  Created by Jason Wei on 7/9/19.
//  Copyright © 2019 Kaifan Wei. All rights reserved.
//

import UIKit
import Firebase

class AddTicketViewController: UIViewController {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var countSlider: UISlider!
    @IBOutlet var countLabel: UILabel!
    
    var sliderInt = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //adding the send button on the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "添加", style: .plain, target: self, action: #selector(addTapped))
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        sliderInt = Int(countSlider.value)
        countLabel.text = "\(sliderInt)"
    }
    
    @objc func addTapped() {
        
        //validate text entry
        if titleField.text?.isEmpty != true {
            
            //initialize constants
            let ticketName = titleField.text!
            let count = sliderInt
            
            let rootRef = Database.database().reference().child("Tickets").child(ticketName)
            rootRef.updateChildValues(["count": count, "issuer": "blank"])
            self.navigationController?.popViewController(animated: true)
            
        } else {
            let emptyAlert = UIAlertController(title: "警告!", message: "你没有填完整哦", preferredStyle: .alert)
            emptyAlert.addAction(UIAlertAction(title: "好吧", style: .default, handler: nil))
            self.present(emptyAlert, animated: true)
        }
    }
    

}
