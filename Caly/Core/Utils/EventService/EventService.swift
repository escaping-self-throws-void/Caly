//
//  EventService.swift
//  Caly
//
//  Created by Paul Matar on 16/08/2023.
//

import EventKit

public protocol EventServicable {
    func checkPermission(for date: Date, eventName: String) async throws -> Bool
}

public final class EventService: EventServicable {
    private let eventStore = EKEventStore()
    
    public func checkPermission(for date: Date, eventName: String) async throws -> Bool {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .notDetermined:
            let success = try await eventStore.requestAccess(to: .event)
            guard success else { return false }
            try insertEvent(store: eventStore, date: date, eventName: eventName)
            return true
        case .restricted:
            throw Error.restricted
        case .denied:
            throw Error.denied
        case .authorized:
            try insertEvent(store: eventStore, date: date, eventName: eventName)
            return true
        @unknown default:
            throw Error.unknown
        }
    }
    
    public func fetchEvents(for date: Date = .now) -> [EKEvent] {
        let store = EKEventStore()
        
        let calendars = store.calendars(for: .event)
        
        var events = [EKEvent]()
        
        for calendar in calendars where calendar.title == "Calendar" {
            let oneMonthAgo = date.addingTimeInterval(-30*24*3600)
            let oneMonthAfter = date.addingTimeInterval(30*24*3600)
            let predicate =  store.predicateForEvents(withStart: oneMonthAgo, end: oneMonthAfter, calendars: [calendar])
            
            let matchedEvents = store.events(matching: predicate)
            events += matchedEvents
        }
        
        return events
    }
}

// MARK: - Private methods
extension EventService {
    private func insertEvent(store: EKEventStore, date: Date, eventName: String) throws {
        let calendars = store.calendars(for: .event)
        for calendar in calendars where calendar.title == "Calendar" {
            let event = EKEvent(eventStore: store)
            event.calendar = calendar
            event.startDate = date
            event.title = eventName
            event.endDate = event.startDate.addingTimeInterval(60*60)
            let reminder = EKAlarm(relativeOffset: -60*30)
            event.alarms = [reminder]
            try store.save(event, span: .thisEvent)
        }
    }
}

// MARK: - Period
extension EventService {
    enum Period {
        case month
        case quarter
        case year
        
        var timeInterval: TimeInterval {
            switch self {
            case .month:
                return 30*24*3600
            case .quarter:
                return 90*24*3600
            case .year:
                return 365*24*3600
            }
        }
    }
}

// MARK: - Error
extension EventService {
    enum Error: LocalizedError {
        case restricted
        case denied
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .restricted:
                return "Calendar access restricted"
            case .denied:
                return "Calendar access restricted"
            case .unknown:
                return "Calendar access unknown issue"
            }
        }
    }
}
