//
//  Coordinator.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
