//
//  CreateCell.swift
//  WalletApp
//
//  Created by Hakan Adanur on 5.02.2023.
//

import Foundation
import UIKit

protocol CreateCellDelegate: AnyObject {
    func saveButtonTapped(title: String,
                          money: String,
                          date: String)
    func cancelButtonTapped()
    func error()
}

class CreateCell: UITableViewCell {
    
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var moneyTextField: UITextField!
    @IBOutlet private weak var dateTextField: UITextField!
    @IBOutlet private weak var createView: UIView!
    
    weak var delegate: CreateCellDelegate?
    var viewModel: CreateVM!
    
    func configure() {
        
        createDatePicker()
        
        
    }
    
    private func createDatePicker(){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
    
    @objc private func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM EEEE h:mm a"
        createView.endEditing(true)
    }
    
    @objc private func cancelDatePicker(){
        createView.endEditing(true)
        
    }
    
    @objc private func dateChange(datePicker: UIDatePicker){
        dateTextField.text = formatDate(date: datePicker.date)
    }
    
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "d MMMM EEEE h:mm a"
        return formatter.string(from: date)
    }
    
    @IBAction private func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, let money = moneyTextField.text, let date = dateTextField.text else { return }
        
        if dateTextField.text != "",
           moneyTextField.text != "",
           titleTextField.text != "" {
            delegate?.saveButtonTapped(title: title, money: money, date: date)
        } else {
            delegate?.error()
        }

    }
    
    @IBAction private func cancelButtonTapped(_ sender: Any) {
        delegate?.cancelButtonTapped()
    }
    
}
