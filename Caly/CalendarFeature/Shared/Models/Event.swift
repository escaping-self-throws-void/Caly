//
//  Event.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import Foundation

struct Event: Hashable {
    let id = UUID()
    let date: DateComponents
    let note: String
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
