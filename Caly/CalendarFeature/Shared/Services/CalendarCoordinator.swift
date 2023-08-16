//
//  CalendarCoordinator.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit

public final class CalendarCoordinator: BaseCoordinator {

    @Injected(.global)
    private var router: Routable

    let mainViewController = MainViewController()
    public override func start() {
        
        mainViewController.viewModel.onAdd = { [weak self] date in
            self?.startAddEvent(date)
        }
        
        router.push(mainViewController, isAnimated: true, onNavigateBack: isCompleted)
    }
    
    private func startAddEvent(_ date: DateComponents) {
        let addEventViewController = AddEventViewController()
        addEventViewController.viewModel.selectedDate = date
        addEventViewController.viewModel.onEventAdded = { [weak self] event in
            self?.mainViewController.viewModel.updateSelected(date: event.date)
            self?.mainViewController.viewModel.events.append(event)
        }
        let navigationController = UINavigationController(rootViewController: addEventViewController)
        router.present(navigationController, isAnimated: true)
    }
}
