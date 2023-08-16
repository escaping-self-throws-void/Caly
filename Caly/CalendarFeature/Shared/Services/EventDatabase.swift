//
//  EventDatabase.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit
import Combine

final class EventDatabase {
    private(set) var eventsTable = [String: [Event]]()
    private(set) var selectedDate = CurrentValueSubject<Date, Never>(.now)
    
    func getEvents(for date: Date) -> [Event] {
        guard let events = eventsTable[date.toString] else {
            return []
        }
        return events
    }
    
    func add(events: [Event], for date: Date) {
        if let storedEvents = eventsTable[date.toString], !storedEvents.isEmpty {
            eventsTable[date.toString]?.append(contentsOf: events)
        } else {
            eventsTable[date.toString] = events
        }
    }
}
