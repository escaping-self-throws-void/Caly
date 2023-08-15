//
//  Stylabe+UIDatePicker.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit

extension Stylable where Self: UIDatePicker {
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
}
