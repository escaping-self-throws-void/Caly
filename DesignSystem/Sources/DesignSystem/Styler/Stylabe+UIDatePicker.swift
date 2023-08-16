//
//  Stylabe+UIDatePicker.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit

public extension Stylable where Self: UIDatePicker {
    @discardableResult
    func preferredDatePickerStyle(_ value: UIDatePickerStyle) -> Self {
        self.preferredDatePickerStyle = value

        return self
    }

    @discardableResult
    func datePickerMode(_ value: UIDatePicker.Mode) -> Self {
        self.datePickerMode = value

        return self
    }
    
    @discardableResult
    func minimumDate(_ value: Date?) -> Self {
        self.minimumDate = value

        return self
    }
    
    @discardableResult
    func maximumDate(_ value: Date?) -> Self {
        self.maximumDate = value

        return self
    }
}
