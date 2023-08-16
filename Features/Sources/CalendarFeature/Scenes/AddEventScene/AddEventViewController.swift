//
//  AddEventViewController.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit
import DesignSystem

final class AddEventViewController: BaseViewController<AddEventView, AddEventViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - Private methods
extension AddEventViewController {
    private func setupViews() {
        title = Text.AddEvent.title
        
        navigationItem.leftBarButtonItem = .init(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped)
        )
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneTapped)
        )
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        viewModel.sync()
        
        customView.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        customView.textField.becomeFirstResponder()

        customView.datePicker.setDate(viewModel.selectedDate, animated: false)
        customView.datePicker.addTarget(self, action: #selector(datePicked), for: .valueChanged)
    }
}

// MARK: - Actions
extension AddEventViewController {
    @objc
    private func cancelTapped(sender: UIBarButtonItem) {
        customView.textField.resignFirstResponder()
        dismiss(animated: true)
    }
    
    @objc
    private func doneTapped(sender: UIBarButtonItem) {
        
        Task {
            customView.activityIndicator.startAnimating()
            defer { customView.activityIndicator.stopAnimating() }
            
            do {
                try await viewModel.addToCalendar()
                viewModel.passSelectedDate()
                dismiss(animated: true)
            } catch {
                show(error: error)
            }
        }
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        navigationItem.rightBarButtonItem?.isEnabled = !text.isEmpty
        viewModel.updateEventNote(text)
    }
    
    @objc
    private func datePicked(_ datePicker: UIDatePicker) {
        viewModel.updateSelected(date: datePicker.date)
    }
}
