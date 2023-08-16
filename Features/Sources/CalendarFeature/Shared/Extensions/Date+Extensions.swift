//
//  Date+ToString.swift
//  Caly
//
//  Created by Paul Matar on 16/08/2023.
//

import Foundation

extension Date {
    var toString: String {
        DateFormatter.date.string(from: self)
    }
    
    var timeText: String {
        DateFormatter.time.string(from: self)
    }
    
    var toComponents: DateComponents {
        Calendar.current.dateComponents([.day, .month, .year, .calendar], from: self)
    }
}
