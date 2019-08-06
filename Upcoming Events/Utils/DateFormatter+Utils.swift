//
//  DateFormatter+Utils.swift
//  Upcoming Events
//
//  Created by Alexander Camacho on 7/29/19.
//  Copyright © 2019 Alexander Camacho. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let mmmmDDyyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy h:mm a"
        return formatter
    }()
    
    static let mmmmDD: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter
    }()
    
    static let hhMMa: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
}
