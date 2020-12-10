//
//  HeadingLabel.swift
//  KodexCoreNetwork
//
//  Created by Jawad on 11/26/20.
//

import UIKit

open class HeadingLabel: UILabel {

    open override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    private func setupButton() {
        self.font = ProjectFont.PopinsBold(18.0).font()
    }
}

open class RegularLabel: UILabel {

    open override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    private func setupButton() {
        self.font = ProjectFont.PopinsRegular(16.0).font()
    }
}

open class NormalLabel: UILabel {

    open override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    private func setupButton() {
        self.font = ProjectFont.PopinsNormal(14.0).font()
    }
}

open class SmallLabel: UILabel {

    open override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    private func setupButton() {
        self.font = ProjectFont.PopinsNormal(12.0).font()
    }
}

open class SmallestLabel: UILabel {

    open override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    private func setupButton() {
        self.font = ProjectFont.PopinsNormal(10.0).font()
    }
}


