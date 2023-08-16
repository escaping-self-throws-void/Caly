//
//  Date+ToString.swift
//  Caly
//
//  Created by Paul Matar on 16/08/2023.
//

import Foundation

extension Date {
    var toString: String {
        DateFormatter.live.string(from: self)
    }
    
    var toComponents: DateComponents {
        Calendar.current.dateComponents([.day, .month, .year, .calendar], from: self)
    }
}
