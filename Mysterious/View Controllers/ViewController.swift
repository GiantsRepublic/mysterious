//
//  ViewController.swift
//  Mysterious
//
//  Created by Jason Wei on 5/30/19.
//  Copyright © 2019 Kaifan Wei. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var ticketTable = [Ticket]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.isHidden = true
        
        let cellNib = UINib(nibName: "UtilityTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "myCell")
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        FirebaseCall()
    }
    
    func FirebaseCall() {
        
        ticketTable.removeAll()
        let rootRef = Database.database().reference().child("Tickets")
        rootRef.observe(.value) { (snapshot) in
            //print(snapshot.value!)
            if snapshot.hasChildren() {
                let value = snapshot.value! as! [String: Any]
                print(value)
                for ticket in value {
                    let title = ticket.key
                    let detail = ticket.value as! [String: Any]
                    let issuer = detail["issuer"] as! String
                    let count = detail["count"] as! Int
                    let ticket = Ticket(title: title, issuer: issuer)
                    ticket.count = count
                    self.ticketTable.append(ticket)
                }
                //self.loaded = true
                self.tableView.isHidden = false
                //self.loadingView.isHidden = true
                self.tableView.reloadData()
            } else {
                //self.loadingLabel.text = "这里空空如也 :("
            }
            
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! UtilityTableViewCell
        cell.ticketNameLabel.text = self.ticketTable[indexPath.row].title
        cell.ticketLeftLabel.text = "\(self.ticketTable[indexPath.row].count)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    

}



