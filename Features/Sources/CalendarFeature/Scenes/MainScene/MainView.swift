//
//  MainView.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit
import DesignSystem

final class MainView: BaseView {
    // MARK: - Outlets
    private(set) lazy var calendarView = UICalendarView()
        .availableDateRange(.init(start: .now, end: .distantFuture))
        .fontDesign(.rounded)
        .backgroundColor(.accent)
        .clipsToBounds(true)
        .cornerRadius(16)
    private(set) lazy var collectionView: UICollectionView = {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.backgroundColor = .clear
        configuration.showsSeparators = false
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor(.clear)
        return collectionView
    }()
    
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
