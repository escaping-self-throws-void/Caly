//
//  AddEventViewModel.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import Foundation

final class AddEventViewModel: NSObject {
    // MARK: - Properties
    @Injected(.global)
    private var dataBase: EventDatabase
    @Injected
    private var eventService: EventServicable
    
    private var eventNote: String = ""
    private(set) var selectedDate: Date = .now
}

// MARK: - Public methods
extension AddEventViewModel {
    func updateSelected(date: Date) {
        selectedDate = date
    }
    
    func updateEventNote(_ note: String) {
        eventNote = note
    }
    
    func syncSelectedDate() {
        updateSelected(date: dataBase.selectedDate.value)
    }
    
    func addEvent() {
        let event = Event(time: selectedDate, note: eventNote)
        dataBase.add(events: [event], for: selectedDate)
        dataBase.selectedDate.send(selectedDate)
    }
    
    func addToCalendar() async throws -> Bool {
        try await eventService.checkPermission(for: selectedDate, eventName: eventNote)
    }
}
