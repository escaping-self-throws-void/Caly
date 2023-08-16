//
//  MainViewModel.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import Foundation
import Combine
import Core

final class MainViewModel: NSObject {
    // MARK: - Properties
    var onAddPressed: VoidClosure?
    private var cancellables = Set<AnyCancellable>()

    @Injected(.global)
    private var dataBase: EventDatabase
    private(set) var selectedDate = CurrentValueSubject<Date, Never>(.now)
    
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
    
    func passSelection() {
        dataBase.passingDate.send(selectedDate.value)
    }
    
    func fetchEvents() {
        dataBase.fetchEvents()
    }
    
    func getEventsPerSelection() -> [Event] {
        dataBase.events
            .filter { $0.time.toString == selectedDate.value.toString }
    }
    
    func getAllEvents() -> [Event] {
        dataBase.events
    }
}

// MARK: - Private methods
extension MainViewModel {
    private func bindDatabase() {
        dataBase.passingDate
            .sink { [weak self] date in
                self?.updateSelected(date: date)
            }.store(in: &cancellables)
    }
}
