//
//  AddEventView.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit
import DesignSystem

final class AddEventView: BaseView {
    // MARK: - Outlets
    private(set) lazy var textField = UITextField()
        .placeholder(Text.AddEvent.placeholder)
    private(set) lazy var datePicker = UIDatePicker()
        .preferredDatePickerStyle(.automatic)
        .datePickerMode(.dateAndTime)
        .minimumDate(.now)
        .maximumDate(.distantFuture)
        .backgroundColor(.accent)
        .tintColor(.accent)
        .clipsToBounds(true)
        .cornerRadius(12)
    private(set) lazy var textFieldTitle = UILabel()
        .text(Text.AddEvent.tfTitle)
        .font(.caprasimo16)
    private(set) lazy var dateTitle = UILabel()
        .text(Text.AddEvent.dTitle)
        .font(.caprasimo16)
    private(set) lazy var timeTitle = UILabel()
        .text(Text.AddEvent.tTitle)
        .font(.caprasimo16)
    private(set) lazy var activityIndicator = UIActivityIndicatorView(style: .medium)
        .hidesWhenStopped(true)
        .tintColor(.accent)
        .stopAnimation()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }
}

// MARK: - Private methods
extension AddEventView {
    private func _init() {
        activityIndicator
            .place(on: self)
            .center(in: self)
       
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

        _ = UIStackView(arrangedSubviews: [textFieldStack, dateStack])
            .axis(.vertical)
            .spacing(16)
            .place(on: self)
            .top(with: safeAreaLayoutGuide.topAnchor, value: 16)
            .leading(with: safeAreaLayoutGuide.leadingAnchor, value: 16)
            .trailing(with: safeAreaLayoutGuide.trailingAnchor, value: -16)
    }
}
