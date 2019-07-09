//
//  Tickets.swift
//  Mysterious
//
//  Created by Jason Wei on 7/9/19.
//  Copyright © 2019 Kaifan Wei. All rights reserved.
//

import Foundation

class Ticket {
    var title: String
    var issuer: String
    var count: Int
    
    init(title: String, issuer: String) {
        self.title = title
        self.count = 1
        self.issuer = issuer
    }
}
