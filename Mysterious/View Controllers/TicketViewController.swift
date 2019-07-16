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
    @IBOutlet var loadingView: UIView!
    @IBOutlet var loadingLabel: UILabel!
    
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
        
        let rootRef = Database.database().reference().child("Tickets")
        rootRef.observe(.value) { (snapshot) in
            self.ticketTable.removeAll()

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
                self.loadingView.isHidden = true
                self.tableView.reloadData()
            } else {
                self.loadingLabel.text = "暂时没有可用的券哦"
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
        cell.ticketLeftLabel.text = "剩余 \(self.ticketTable[indexPath.row].count) 张"
        cell.issuerLabel.text = self.ticketTable[indexPath.row].issuer
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //validate ticket count
        let selectedTicket = self.ticketTable[indexPath.row]
        if selectedTicket.count > 0 && selectedTicket.issuer != user {
            //alert actions
            let confirmAlert = UIAlertController(title: "你确定吗!", message: "你确定要使用\(self.ticketTable[indexPath.row].title)吗", preferredStyle: .alert)
            confirmAlert.addAction(UIAlertAction(title: "确定！", style: .default, handler: {action in self.confirmHandler(ticket: self.ticketTable[indexPath.row])}))
            confirmAlert.addAction(UIAlertAction(title: "我再想想", style: .cancel, handler: nil))
            self.present(confirmAlert, animated: true)
        } else if selectedTicket.issuer == user{
            let alert = UIAlertController(title: "警告⚠️", message: "你不可以使用自己颁发的\(self.ticketTable[indexPath.row].title)哦", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好吧！", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func confirmHandler (ticket: Ticket) {
        //print("confirm pressed")
        
        
        var count = ticket.count
        if count > 1 {
            count = count - 1
            let rootRef = Database.database().reference().child("Tickets").child(ticket.title)
            rootRef.updateChildValues(["count": count, "issuer": ticket.issuer])
        } else if count == 1 {
            let rootRef = Database.database().reference().child("Tickets").child(ticket.title)
            rootRef.removeValue()
            
            self.tableView.isHidden = true
            self.loadingView.isHidden = false
            self.loadingLabel.text = "暂时没有可用的券哦"
        }
        
    }

}



