//
//  DatePickerTextField.swift
//  KodexCoreNetwork
//
//  Created by Jawad on 12/10/20.
//

import Foundation
import UIKit
protocol DatePickerTextFieldDelegate {
    func dateUpdate()
}
class DatePickerTextField: UITextField {
    var update_delegate : DatePickerTextFieldDelegate?
    private var privateDate: Date?
    var date: Date? {
        set {
            privateDate = newValue
            if !isFirstResponder {
                datePicker.setDate(newValue!, animated: false)
            }
        }
        get {
            return privateDate
        }
    }
    
    private lazy var dateFormatter = DateFormatter()
    
    @IBInspectable var dateFormat: String = "dd MMMM yyyy" {
        didSet {
            dateFormatter.dateFormat = dateFormat
        }
    }
    
    private lazy var datePicker = UIDatePicker()
    
    var datePickerMode: UIDatePicker.Mode = .date {
        didSet {
            datePicker.datePickerMode = datePickerMode
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        datePicker.timeZone =  TimeZone.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = dateFormat
        if date != nil {
            datePicker.setDate(date!, animated: false)
        }
        datePicker.addTarget(self, action: #selector(didSelectDate(_:)), for: .valueChanged)
        datePicker.datePickerMode = datePickerMode
        datePicker.timeZone = .current
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            
        }
        datePicker.contentMode = .scaleAspectFill
        datePicker.frame.size.height = 400
//        datePicker.autoresizingMask = [
//            UIView.AutoresizingMask.flexibleWidth,
//            UIView.AutoresizingMask.flexibleHeight
//        ]
        inputView = datePicker
    }
    @objc private func didSelectDate(_ sender: UIDatePicker) {
        date = sender.date
        text = dateFormatter.string(from: sender.date)
        self.resignFirstResponder()
        update_delegate!.dateUpdate()
    }
}
