//
//  MainViewController.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit

final class MainViewController: UIViewController {
    private lazy var calendarView: UIDatePicker = {
        let view = UIDatePicker()
        view.preferredDatePickerStyle = .inline
        view.backgroundColor = .systemMint
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .white
        layoutViews()
    }
    
    private func setupNavigationBar() {
        title = "Events Calendar"
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTapped)
        )
    }
    
    @objc
    private func addTapped() {
        
    }
    
    private func layoutViews() {
        calendarView.place(on: view).pin(
            .centerX,
            .top(to: view.safeAreaLayoutGuide, .top, padding: 16),
            .trailing(to: view.safeAreaLayoutGuide, .trailing, padding: 16),
            .leading(to: view.safeAreaLayoutGuide, .leading, padding: 16),
            .fixedHeight(400)
        )
    }
}

