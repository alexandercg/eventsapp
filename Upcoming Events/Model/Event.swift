//
//  Event.swift
//  Upcoming Events
//
//  Created by Alexander Camacho on 7/29/19.
//  Copyright © 2019 Alexander Camacho. All rights reserved.
//

import Foundation

/*
 With this model we are assuming that the json file it will always contain the following format with no optional values.
 
[ {"title": "Evening Picnic",
  "start": "November 10, 2018 6:00 PM",
  "end": "November 10, 2018 7:00 PM"},
 ...]
 */

struct Event: Decodable {
    
    var title: String
    var startDate: Date
    var endDate: Date
    
    var dateComponents: DateComponents {
        return Calendar.current.dateComponents([.day, .year, .month], from: startDate)
    }
    
    var hasConflict = false
    
    // helper init func
    init() {
        title = ""
        startDate = Date()
        endDate = Date()
    }
    
    private enum CodingKeys: String, CodingKey {
        case title
        case startDate = "start"
        case endDate = "end"
    }

}
