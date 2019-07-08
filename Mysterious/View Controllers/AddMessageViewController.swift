//
//  AddMessageViewController.swift
//  Mysterious
//
//  Created by Jason Wei on 5/30/19.
//  Copyright © 2019 Kaifan Wei. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddMessageViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var bodyTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting textfield borders
        self.textView.layer.borderColor = UIColor.lightGray.cgColor
        self.textView.layer.borderWidth = 1
        
        //adding the send button on the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        let date = Date()
        let dateString = date.toString(dateFormat: "yyyy-MM-dd")
        if titleTextField.text?.isEmpty == false && bodyTextField.text.isEmpty == false {
            let title = titleTextField.text!
            let body = bodyTextField.text!
            let rootRef = Database.database().reference().child("Messages").child(title)
            rootRef.updateChildValues(["body": body, "date": dateString])
            self.navigationController?.popViewController(animated: true)
        } else {
            let emptyAlert = UIAlertController(title: "警告!", message: "标题和内容都要写噢~", preferredStyle: .alert)
            emptyAlert.addAction(UIAlertAction(title: "好吧", style: .default, handler: nil))
            self.present(emptyAlert, animated: true)
        }
        
    }

}

extension Date {
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
