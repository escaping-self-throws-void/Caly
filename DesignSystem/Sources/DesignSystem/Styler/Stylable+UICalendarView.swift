//
//  Stylable+UICalendarView.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit

public extension Stylable where Self: UICalendarView {
    @discardableResult
    func calendar(_ value: Calendar) -> Self {
        self.calendar = value

        return self
    }

    @discardableResult
    func fontDesign(_ value: UIFontDescriptor.SystemDesign) -> Self {
        self.fontDesign = value

        return self
    }
    
    @discardableResult
    func availableDateRange(_ value: DateInterval) -> Self {
        self.availableDateRange = value

        return self
    }
}
