//
//  API.swift
//  Upcoming Events
//
//  Created by Alexander Camacho on 7/29/19.
//  Copyright © 2019 Alexander Camacho. All rights reserved.
//

import Foundation

final class DataClient {
    
    init() {}
    
    func getEvents() -> [Event] {
        // try to read the data from mock.json file
        guard let url = Bundle.main.url(forResource: "mock", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return []
        }
        
        // perform the decoding of the data
        do {
            let jsonDecoder = JSONDecoder()
            // setup date decode strategy for this format `MMMM dd, yyyy h:mm a`
            jsonDecoder.dateDecodingStrategy = .formatted(.mmmmDDyyyy)
            
            let events = try jsonDecoder.decode([Event].self, from: data)
            return events
        } catch let error {
            assertionFailure(error.localizedDescription)
            return []
        }
        
    }
}


