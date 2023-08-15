//
//  AddEventView.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit

final class AddEventView: BaseView {
    // MARK: - Outlets
    private(set) lazy var textField = UITextField()
        .placeholder(Text.placeholder)
    private(set) lazy var datePicker = UIDatePicker()
        .preferredDatePickerStyle(.compact)
        .datePickerMode(.date)
        .backgroundColor(.accent)
        .tintColor(.accent)
        .clipsToBounds(true)
        .cornerRadius(12)
    private(set) lazy var timePicker = UIDatePicker()
        .preferredDatePickerStyle(.compact)
        .datePickerMode(.time)
        .backgroundColor(.accent)
        .clipsToBounds(true)
        .cornerRadius(12)
    private(set) lazy var textFieldTitle = UILabel()
        .text("Event Title")
        .font(.caprasimo16)
    private(set) lazy var dateTitle = UILabel()
        .text("Date")
        .font(.caprasimo16)
    private(set) lazy var timeTitle = UILabel()
        .text("Time")
        .font(.caprasimo16)
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }
}

// MARK: - Private methods
extension AddEventView {
    private func _init() {
        let textFieldContainer = UIView()
            .backgroundColor(.accent)
            .clipsToBounds(true)
            .cornerRadius(12)
            .height(value: 35)
        textField
            .snap(to: textFieldContainer, insets: .init(top: 5, left: 10, bottom: -5, right: -10))
        
        let textFieldStack = UIStackView(arrangedSubviews: [textFieldTitle, textFieldContainer])
            .axis(.vertical)
            .spacing(5)
            .distribution(.fill)
        let dateStack = UIStackView(arrangedSubviews: [dateTitle, datePicker])
            .axis(.vertical)
            .spacing(5)
            .distribution(.fill)
            .alignment(.leading)
        
        let timeStack = UIStackView(arrangedSubviews: [timeTitle, timePicker])
            .axis(.vertical)
            .spacing(5)
            .distribution(.fill)
            .alignment(.leading)
            .width(value: 100)
        
        let calendarStack = UIStackView(arrangedSubviews: [dateStack, timeStack])
            .axis(.horizontal)
            .spacing(16)
            .distribution(.equalCentering)
            .alignment(.leading)
        
        _ = UIStackView(arrangedSubviews: [textFieldStack, calendarStack])
            .axis(.vertical)
            .spacing(16)
            .place(on: self)
            .top(with: safeAreaLayoutGuide.topAnchor, value: 16)
            .leading(with: safeAreaLayoutGuide.leadingAnchor, value: 16)
            .trailing(with: safeAreaLayoutGuide.trailingAnchor, value: -16)
    }
}
