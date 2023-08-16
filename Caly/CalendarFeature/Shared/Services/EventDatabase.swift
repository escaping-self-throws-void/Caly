//
//  EventDatabase.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit
import Combine

final class EventDatabase {
    @Injected
    private var eventService: EventServicable
    private(set) var events = [Event]()
    private(set) var passingDate = CurrentValueSubject<Date, Never>(.now)
    
    func fetchEvents() {
        let ekEvents = eventService.fetchEvents(.now)
        events = ekEvents.map { Event(time: $0.startDate, note: $0.title) }
    }
    
    func saveEvent(_ date: Date, title: String) async throws {
        let ekEvent = try await eventService.insertEvent(date, title: title)
        let event = Event(time: ekEvent.startDate, note: ekEvent.title)
        events.append(event)
    }
}
