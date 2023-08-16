//
//  MainViewModel.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import Foundation
import Combine


import EventKit


final class MainViewModel: NSObject {
    // MARK: - Properties
    var onAddPressed: VoidClosure?

    @Injected(.global)
    private var dataBase: EventDatabase
    private var cancellables = Set<AnyCancellable>()
    private(set) var selectedDate = CurrentValueSubject<Date, Never>(.now)

    private(set) var events = [Event]()
    
    // MARK: - Lifecycle
    override init() {
        super.init()
        bindDatabase()
    }
}

// MARK: - Public methods
extension MainViewModel {
    func updateSelected(date: Date) {
        selectedDate.send(date)
    }
    
    func syncSelectedDate() {
        dataBase.selectedDate.send(selectedDate.value)
    }
    
    func fetchEvents() {
        events = dataBase.getEvents(for: selectedDate.value)
    }
    
    func ffff() {
        
        let store = EKEventStore()
        
        let calendars = store.calendars(for: .event)
        
        for calendar in calendars where calendar.title == "Calendar" {
            let oneMonthAgo = Date(timeIntervalSinceNow: -30*24*3600)
            let oneMonthAfter = Date(timeIntervalSinceNow: 30*24*3600)
            let predicate =  store.predicateForEvents(withStart: oneMonthAgo, end: oneMonthAfter, calendars: [calendar])
            
            let events = store.events(matching: predicate)
            
            self.events = events.map { Event(time: $0.startDate, note: $0.title) }
        }
    }
}

// MARK: - Private methods
extension MainViewModel {
    private func bindDatabase() {
        dataBase.selectedDate
            .sink { [weak self] date in
                self?.ffff()
                self?.updateSelected(date: date)
            }.store(in: &cancellables)
    }
}
