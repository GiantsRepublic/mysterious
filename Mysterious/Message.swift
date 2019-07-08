//
//  Message.swift
//  Mysterious
//
//  Created by Jason Wei on 5/30/19.
//  Copyright © 2019 Kaifan Wei. All rights reserved.
//

import Foundation

class Message {
    var title: String
    var body: String
    var timeStamp: String
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
        self.timeStamp = ""
    }
}
