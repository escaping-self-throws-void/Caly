//
//  MainViewController.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit
import Combine

final class MainViewController: BaseViewController<MainView, MainViewModel> {
    // MARK: - Properties
    private lazy var dataSource = makeDataSource()
    private lazy var dateSelection = UICalendarSelectionSingleDate(delegate: self)
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
        viewModel.ffff()
    }
}

// MARK: - Private methods
extension MainViewController {
    private func setupViews() {
        title = Text.Main.title
        
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTapped)
        )
        
        customView.calendarView.selectionBehavior = dateSelection
        customView.calendarView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.selectedDate
            .receive(on: DispatchQueue.main)
            .sink { [weak self] date in
                guard let self else { return }
//                viewModel.fetchEvents()
                dataSource.apply(makeSnapshot(viewModel.events.filter { $0.time.toString == self.viewModel.selectedDate.value.toString }), animatingDifferences: false)
                reload(selected: date)
            }.store(in: &cancellables)
    }
    
    private func reload(selected date: Date) {
        customView.calendarView.reloadDecorations(forDateComponents: [date.toComponents], animated: true)
        dateSelection.setSelected(date.toComponents, animated: true)
    }
}

// MARK: - Actions
extension MainViewController {
    @objc
    private func addTapped() {
        viewModel.syncSelectedDate()
        viewModel.onAddPressed?()
    }
}

// MARK: - UICalendarViewDelegate
extension MainViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        for event in viewModel.events where event.time.toString == dateComponents.date?.toString {
            return .image(.init(systemName: Images.Main.note), color: .systemTeal)
        }
        return nil
    }
    
    func calendarView(_ calendarView: UICalendarView, didChangeVisibleDateComponentsFrom previousDateComponents: DateComponents) {
        calendarView.reloadDecorations(forDateComponents: [previousDateComponents], animated: true)
    }
}

// MARK: - UICalendarSelectionSingleDateDelegate
extension MainViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        if let dateComponents, let date = dateComponents.date {
            viewModel.updateSelected(date: date)
            customView.calendarView.reloadDecorations(forDateComponents: [dateComponents], animated: true)
        }
    }
}

// MARK: - DiffableDataSource setup
extension MainViewController {
    typealias Snapshot = NSDiffableDataSourceSnapshot<String, Event>
    typealias DataSource = UICollectionViewDiffableDataSource<String, Event>

    private func makeDataSource() -> DataSource {
        /// Cell registration & configuration
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Event> { cell, _, model in
            var content = EventCellConfiguration()
            content.date = model.time
            content.eventName = model.note
            cell.contentConfiguration = content
            
            var backgroundConfiguration = UIBackgroundConfiguration.listPlainCell()
            backgroundConfiguration.backgroundColor = .clear
            cell.backgroundConfiguration = backgroundConfiguration
        }
        
        return DataSource(collectionView: customView.collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
    
    private func makeSnapshot(_ models: [Event]) -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([""])
        snapshot.appendItems(models, toSection: "")
        return snapshot
    }
}
