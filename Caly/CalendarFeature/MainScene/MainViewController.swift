//
//  MainViewController.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit

final class MainViewController: BaseViewController<MainView, MainViewModel> {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
}

// MARK: - Private methods
extension MainViewController {
    private func setupNavigationBar() {
        title = Text.Main.title
        
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTapped)
        )
    }
}

// MARK: - Actions
extension MainViewController {
    @objc
    private func addTapped() {
        viewModel.onAdd?()
    }
}

