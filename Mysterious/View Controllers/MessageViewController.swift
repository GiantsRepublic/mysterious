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
    @IBOutlet var loadingView: UIView!
    
    @IBOutlet var loadingLabel: UILabel!
    @IBOutlet var VPNLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register custom cell nib
        let cellNib = UINib(nibName: "MessageTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "myCell")
        
        tabBarItem.image = tabBarItem.image?.withRenderingMode(.alwaysTemplate)
        print(user)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        FirebaseCall()
    }
    
    func FirebaseCall() {

        let rootRef = Database.database().reference().child("Messages")
        rootRef.observe(.value) { (snapshot) in
            
            //remove all previous values
            self.msgTable.removeAll()
            
            //var count = 0

            //print(snapshot.value!)
            if snapshot.hasChildren() {
                let value = snapshot.value! as! [String: Any]
                //print(value)
                for msg in value {
                    let title = msg.key
                    let detail = msg.value as! [String: Any]
                    let body = detail["body"] as! String
                    let date = detail["date"] as! String
                    let count = detail["count"] as! Int
                    let sender = detail["sender"] as! String
                    let read = detail["read"] as! String
                    let message = Message(title: title, body: body, count: count, sender: sender)
                    message.timeStamp = date
                    message.read = read
                    self.msgTable.append(message)
                }
                
                //sort msgTable by count
                var tempTable = self.msgTable
                for message in self.msgTable {
                    tempTable[message.count] = message
                }
                
                self.msgTable = tempTable.reversed()
                
                self.loaded = true
                self.tableView.isHidden = false
                self.loadingView.isHidden = true
                self.tableView.reloadData()
            } else {
                self.loadingLabel.text = "这里空空如也 :("
            }
            
        }
    }

}

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MessageTableViewCell
        
        if msgTable[indexPath.row].read == "false" {
            cell.newLabel.isHidden = false
        } else {
            cell.newLabel.isHidden = true
        }
        
        
        
        //set cell texts
        cell.titleLabel.text = msgTable[indexPath.row].title
        cell.dateLabel.text = msgTable[indexPath.row].timeStamp
        cell.nameLabel.text = msgTable[indexPath.row].sender
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
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
