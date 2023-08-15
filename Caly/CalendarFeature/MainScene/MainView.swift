//
//  MainView.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit

final class MainView: BaseView {
    // MARK: - Outlets
    private(set) lazy var calendarView = UIDatePicker()
        .preferredDatePickerStyle(.inline)
        .datePickerMode(.date)
        .backgroundColor(.accent)
        .clipsToBounds(true)
        .cornerRadius(16)
    
    private(set) lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
        .backgroundColor(.clear)
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }
}

// MARK: - Private methods
extension MainView {
    private func _init() {
        calendarView
            .place(on: self)
            .top(with: safeAreaLayoutGuide.topAnchor, value: 16)
            .leading(with: safeAreaLayoutGuide.leadingAnchor, value: 16)
            .trailing(with: safeAreaLayoutGuide.trailingAnchor, value: -16)
        
        collectionView
            .place(on: self)
            .top(with: calendarView.bottomAnchor, value: 16)
            .bottom(with: safeAreaLayoutGuide.bottomAnchor, value: -16)
            .leading(with: safeAreaLayoutGuide.leadingAnchor, value: 16)
            .trailing(with: safeAreaLayoutGuide.trailingAnchor, value: -16)
    }
}
