//
//  MainViewController.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit

final class MainViewController: BaseViewController<MainView, MainViewModel> {
    // MARK: - Properties
    private lazy var dataSource = makeDataSource()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        dateSelection.setSelected(viewModel.selectedDate, animated: true)
        customView.calendarView.selectionBehavior = dateSelection
        customView.calendarView.delegate = self

        viewModel.updateUI = { [weak self] in
            guard let self else { return }
            customView.calendarView.reloadDecorations(forDateComponents: [viewModel.selectedDate], animated: true)
            dateSelection.setSelected(viewModel.selectedDate, animated: true)
            dataSource.apply(makeSnapshot(viewModel.events))
        }
    }
}

// MARK: - Actions
extension MainViewController {
    @objc
    private func addTapped() {
        viewModel.onAdd?(viewModel.selectedDate)
    }
}

// MARK: - UICalendarViewDelegate
extension MainViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        for event in viewModel.events where event.date.date?.toString == dateComponents.date?.toString {
            return .image(.init(systemName: Images.Main.note), color: .systemTeal)
        }
        return nil
    }
}

// MARK: - UICalendarSelectionSingleDateDelegate
extension MainViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        if let dateComponents {
            viewModel.updateSelected(date: dateComponents)
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
            content.date = model.date.date ?? .now
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
