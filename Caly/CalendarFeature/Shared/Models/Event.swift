//
//  Event.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import Foundation

struct Event {
    let id = UUID()
    let time: Date
    let note: String
}

// MARK: - Hashable
extension Event: Hashable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
