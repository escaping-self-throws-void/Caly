//
//  EventCell.swift
//  Caly
//
//  Created by Paul Matar on 16/08/2023.
//

import UIKit
import DesignSystem

final class EventCell: UIView, UIContentView {
    // MARK: - ContentConfiguration
    var configuration: UIContentConfiguration {
        get {
            currentConfiguration
        }
        set {
            guard let newConfiguration = newValue as? EventCellConfiguration else { return }
            currentConfiguration = newConfiguration
            applyConfiguration()
        }
    }
    
    private var currentConfiguration: EventCellConfiguration!
    
    // MARK: - Outlets
    private lazy var lineView = UIView()
        .backgroundColor(.systemTeal)
        .clipsToBounds(true)
        .cornerRadius(2)
    private lazy var eventLabel = UILabel()
        .text("New Event")
        .font(.caprasimo16)
    private lazy var timeLabel = UILabel()
        .text("17:00")
        .font(.caprasimo16)
    
    // MARK: - Lifecycle
    init(_ configuration: EventCellConfiguration) {
        super.init(frame: .zero)
        _init()
        currentConfiguration = configuration
        applyConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
extension EventCell {
    private func applyConfiguration() {
        timeLabel.text = currentConfiguration.date.timeText
        eventLabel.text = currentConfiguration.eventName
    }
    
    private func _init() {
        let mainStack = UIStackView(arrangedSubviews: [lineView, eventLabel, timeLabel])
            .axis(.horizontal)
            .distribution(.fill)
            .alignment(.center)
            .spacing(10)
            .backgroundColor(.accent)
            .cornerRadius(16)
            .clipsToBounds(true)
        
        mainStack
            .snap(to: self, insets: .init(top: 10, left: 0, bottom: -10, right: 0))
        mainStack
            .height(value: 60)
        
        lineView
            .leading(to: mainStack, value: 10)
            .top(to: mainStack, value: 10)
            .bottom(to: mainStack, value: -10)
            .width(value: 3)
        timeLabel
            .width(value: 100)
    }
}
