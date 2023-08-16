//
//  EventCellConfiguration.swift
//  Caly
//
//  Created by Paul Matar on 16/08/2023.
//

import UIKit

struct EventCellConfiguration {
    var eventName = ""
    var date = Date()
}

// MARK: - UIContentConfiguration
extension EventCellConfiguration: UIContentConfiguration {
    func makeContentView() -> UIView & UIContentView {
        EventCell(self)
    }
    
    func updated(for state: UIConfigurationState) -> EventCellConfiguration {
        self
    }
}
