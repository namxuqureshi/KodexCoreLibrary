//
//  Switch+Extension.swift
//  DuetApp
//
//  Created by J Aiden on 6/17/19.
//  Copyright © 2019 
//

import Foundation

import UIKit
@IBDesignable

class UISwitchCustom: UISwitch {
    @IBInspectable var OffTint: UIColor? {
        didSet {
            self.tintColor = OffTint
            self.layer.cornerRadius = 16
            self.backgroundColor = OffTint
        }
    }
}
