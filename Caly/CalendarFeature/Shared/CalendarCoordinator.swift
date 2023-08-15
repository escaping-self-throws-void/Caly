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

    public override func start() {
        let mainViewController = MainViewController()
        router.push(mainViewController, isAnimated: true, onNavigateBack: isCompleted)
    }
}
