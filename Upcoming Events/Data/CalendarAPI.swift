//
//  CalendarAPI.swift
//  Upcoming Events
//
//  Created by Alexander Camacho on 7/29/19.
//  Copyright © 2019 Alexander Camacho. All rights reserved.
//

import Foundation

final class CalendarAPI {
    
    private let dataClient: DataClient
    
    init(dataClient: DataClient = DataClient()) {
        self.dataClient = dataClient
    }
    
    func getGroupedEvents() -> [[Event]] {
        // get events from data client and sort it chronological by start date
        let events = dataClient.getEvents().sorted(by: { $0.startDate < $1.startDate }) // complexity of sort: O(*n* log *n*)
        
        var grouped:[[Event]] = []
        
        // for loop to start grouping the events of the same month/day/year
        // complexity of grouping/checkConflicts : O(n)
        for var event in events {
            if let previousEvent = grouped.last?.last, previousEvent.dateComponents == event.dateComponents {
                //validate if the event has conflicts with the previous event
                event.hasConflict = hasConflict(previousEvent, event)
                // append event to the group of this date
                grouped[grouped.count - 1].append(event)
            } else {
                // start a new group of new date
                grouped.append([event])
            }
        }
        
        return grouped
    }
    
    private func hasConflict(_ previousEvent: Event, _ currentEvent: Event) -> Bool {
        // validate the overlapping of events
        return previousEvent.endDate > currentEvent.startDate
    }
    
}
