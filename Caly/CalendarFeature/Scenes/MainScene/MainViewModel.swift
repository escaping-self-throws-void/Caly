//
//  MainViewModel.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import Foundation

final class MainViewModel: NSObject {
    var onAdd: Closure<DateComponents>?
    var updateUI: VoidClosure?
    var events = [Event]() {
        didSet {
            dump(events)
            updateUI?()
        }
    }
    private(set) var selectedDate: DateComponents = {
        Calendar.current.dateComponents([.day, .month, .year, .calendar], from: .now)
    }()
    
    func updateSelected(date: DateComponents) {
        selectedDate = date
    }
    
}
