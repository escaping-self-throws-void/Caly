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

public final class EventService {
    func checkPermission(for date: Date, eventName: String) async throws -> Bool {
        let eventStore = EKEventStore()
        
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
