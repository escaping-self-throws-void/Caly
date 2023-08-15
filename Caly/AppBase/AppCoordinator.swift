//
//  AppCoordinator.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
     
    private let window: UIWindow
        
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let navigationController = UINavigationController()
        
        DIContainer.register(
            type: Routable.self,
            scope: .global,
            implementer: Router(navigationController: navigationController)
        )

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
                
        let calendarCoordinator = CalendarCoordinator()
        start(coordinator: calendarCoordinator)
    }
}
