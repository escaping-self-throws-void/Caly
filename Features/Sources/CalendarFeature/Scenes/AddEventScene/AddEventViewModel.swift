//
//  AddEventViewModel.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import Foundation
import Core

final class AddEventViewModel: NSObject {
    // MARK: - Properties
    @Injected(.global)
    private var dataBase: EventDatabase

    
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
    
    func passSelectedDate() {
        dataBase.passingDate.send(selectedDate)
    }
    
    func sync() {
        updateSelected(date: dataBase.passingDate.value)
    }
    
    func addToCalendar() async throws {
        try await dataBase.saveEvent(selectedDate, title: eventNote)
    }
}
