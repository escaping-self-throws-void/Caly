//
//  AddEventViewController.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit

final class AddEventViewController: BaseViewController<AddEventView, AddEventViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

}

// MARK: - Private methods
extension AddEventViewController {
    private func setupNavigationBar() {
        title = Text.AddEvent.title
        
        navigationItem.leftBarButtonItem = .init(
            barButtonSystemItem: .cancel,
            target: self,
            action: nil
        )
        
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .done,
            target: self,
            action: nil
        )
        customView.textField.delegate = self
        customView.textField.becomeFirstResponder()
    }
}

extension AddEventViewController: UITextFieldDelegate {
    
}


