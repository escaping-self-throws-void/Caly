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
        
        customView.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        customView.textField.becomeFirstResponder()
        let date = viewModel.selectedDate.date ?? .now
        customView.datePicker.setDate(date, animated: false)
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
        let event = Event(date: viewModel.selectedDate, note: viewModel.eventNote)
        viewModel.onEventAdded?(event)
        dismiss(animated: true)
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        navigationItem.rightBarButtonItem?.isEnabled = !text.isEmpty
        viewModel.eventNote = text
    }
    
    @objc
    private func datePicked(_ datePicker: UIDatePicker) {
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .calendar], from: datePicker.date)
        viewModel.selectedDate = dateComponents
    }
}
