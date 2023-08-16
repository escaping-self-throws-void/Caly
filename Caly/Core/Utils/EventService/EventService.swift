//
//  EventService.swift
//  Caly
//
//  Created by Paul Matar on 16/08/2023.
//

import EventKit

public protocol EventServicable {
    func fetchEvents(_ date: Date) -> [EKEvent]
    func insertEvent(_ date: Date, title: String) async throws -> EKEvent
}

public final class EventService: EventServicable {
    private let eventStore = EKEventStore()

    public func fetchEvents(_ date: Date = .now) -> [EKEvent] {
        let calendars = eventStore.calendars(for: .event)
        var events = [EKEvent]()
        
        for calendar in calendars where calendar.title == "Calendar" {
            let halfYearAgo = date.addingTimeInterval(-6*30*24*3600)
            let halfYearAfter = date.addingTimeInterval(6*30*24*3600)
            let predicate =  eventStore.predicateForEvents(withStart: halfYearAgo, end: halfYearAfter, calendars: [calendar])
            
            let matchedEvents = eventStore.events(matching: predicate)
            events += matchedEvents
        }
        
        return events
    }
    
    public func insertEvent(_ date: Date, title: String) async throws -> EKEvent {
        guard try await checkPermission() else { throw Error.noPermission }
        
        let calendars = eventStore.calendars(for: .event)
        var result: EKEvent?
        
        for calendar in calendars where calendar.title == "Calendar" {
            let event = EKEvent(eventStore: eventStore)
            event.calendar = calendar
            event.startDate = date
            event.title = title
            event.endDate = event.startDate.addingTimeInterval(60*60)
            let reminder = EKAlarm(relativeOffset: -60*30)
            event.alarms = [reminder]
            try eventStore.save(event, span: .thisEvent)
            result = event
        }
        
        guard let result else { throw Error.failedToSave }
        return result
    }
}

// MARK: - Private methods
extension EventService {
    private func checkPermission() async throws -> Bool {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .notDetermined:
            return try await eventStore.requestAccess(to: .event)
        case .restricted:
            throw Error.restricted
        case .denied:
            throw Error.denied
        case .authorized:
            return true
        @unknown default:
            throw Error.unknown
        }
    }
}

// MARK: - Error
extension EventService {
    enum Error: LocalizedError {
        case restricted
        case denied
        case unknown
        case noPermission
        case failedToSave
        
        var errorDescription: String? {
            switch self {
            case .restricted:
                return "Calendar access restricted"
            case .denied:
                return "Calendar access restricted"
            case .unknown:
                return "Calendar access unknown issue"
            case .noPermission:
                return "No permission to access calendar"
            case .failedToSave:
                return "Failed to save to calendar"
            }
        }
    }
}
