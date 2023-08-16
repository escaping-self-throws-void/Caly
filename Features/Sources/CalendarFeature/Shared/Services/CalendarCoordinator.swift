//
//  CalendarCoordinator.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit
import Core

public final class CalendarCoordinator: BaseCoordinator {

    @Injected(.global)
    private var router: Routable
    
    public override init() {}

    public override func start() {
        DIContainer.register(type: EventServicable.self, implementer: EventService())
        DIContainer.register(type: EventDatabase.self, scope: .global, implementer: EventDatabase())
        
        let mainViewController = MainViewController()
        mainViewController.viewModel.onAddPressed = { [weak self] in
            self?.startAddEvent()
        }
        router.push(mainViewController, isAnimated: true, onNavigateBack: isCompleted)
    }
    
    private func startAddEvent() {
        let addEventViewController = AddEventViewController()
        let navigationController = UINavigationController(rootViewController: addEventViewController)
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [
                .custom(identifier: .large) { context in
                    return context.maximumDetentValue * 0.75
                },
                .custom(identifier: .medium) { _ in
                    return 300
                },
            ]
            sheet.selectedDetentIdentifier = .large
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
            router.present(navigationController, isAnimated: true)
        } else {
            router.present(navigationController, isAnimated: true)
        }
    }
}
