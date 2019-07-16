//
//  DetailMessageViewController.swift
//  Mysterious
//
//  Created by Jason Wei on 7/5/19.
//  Copyright © 2019 Kaifan Wei. All rights reserved.
//

import UIKit
import Firebase

class DetailMessageViewController: UIViewController {
    
    var msg: Message!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(msg.title)

        titleLabel.text = msg.title
        bodyText.text = msg.body
        
        let rootRef = Database.database().reference().child("Messages")
        rootRef.child("\(msg.title)").updateChildValues(["read": "true"])
    }
    


}
