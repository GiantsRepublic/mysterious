//
//  MessageViewController.swift
//  Mysterious
//
//  Created by Jason Wei on 5/30/19.
//  Copyright © 2019 Kaifan Wei. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class MessageViewController: UIViewController {
    
    var loaded = false
    var msgTable = [Message]()
    var index = 0
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        FirebaseCall()
    }
    
    func FirebaseCall() {
        msgTable.removeAll()
        let rootRef = Database.database().reference().child("Messages")
        rootRef.observe(.value) { (snapshot) in
            //print(snapshot.value!)
            if snapshot.hasChildren() {
                let value = snapshot.value! as! [String: Any]
                print(value)
                for msg in value {
                    let title = msg.key
                    let detail = msg.value as! [String: String]
                    let body = detail["body"]
                    let date = detail["date"]
                    let message = Message(title: title, body: body!)
                    message.timeStamp = date!
                    self.msgTable.append(message)
                }
                self.loaded = true
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
            
        }
    }

}

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = msgTable[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        self.performSegue(withIdentifier: "messageDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messageDetail" {
            let destVC = segue.destination as! DetailMessageViewController
            destVC.msg = self.msgTable[self.index]
        }
    }
    
    
}
