//
//  AddEventViewModel.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import Foundation

final class AddEventViewModel: NSObject {
    var selectedDate: DateComponents = {
        Calendar.current.dateComponents([.day, .month, .year, .calendar], from: .now)
    }()
    var onEventAdded: Closure<Event>?
    var eventNote: String = ""
}
