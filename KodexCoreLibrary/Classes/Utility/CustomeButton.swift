//
//  CustomeButton.swift
//  KodexCoreNetwork
//
//  Created by Jawad on 11/26/20.
//

import UIKit

open class  CustomeButton: UIButton {
    @IBInspectable
    var titleText: String? {
        didSet {
            self.setTitle(titleText, for: .normal)
        }
    }
    
    @IBInspectable
    open override var backgroundColor: UIColor? {
        didSet {
            self.setTitleColor(.white, for: .normal)
        }
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    private func setupButton() {
        self.backgroundColor = ProjectColor.buttonColor
        self.setTitleColor(ProjectColor.buttonSelectedColor, for: .highlighted)
        self.titleLabel?.font = ProjectFont.PopinsBold(16.0).font()
        self.heightAnchor.constraint(equalToConstant: 56).isActive = true
        self.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}

class  CustomeButtonWithoutBG: UIButton {
    @IBInspectable
    var titleText: String? {
        didSet {
            self.setTitle(titleText, for: .normal)
        }
    }

    @IBInspectable
    override var backgroundColor: UIColor? {
        didSet {
            self.setTitleColor(.white, for: .normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    private func setupButton() {
        self.setTitleColor(ProjectColor.buttonSelectedColor, for: .highlighted)
        self.titleLabel?.font = ProjectFont.PopinsBold(16.0).font()
        self.heightAnchor.constraint(equalToConstant: 56).isActive = true
        self.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}


class  CustomeButtonNormalFont: UIButton {
    @IBInspectable
    var titleText: String? {
        didSet {
            self.setTitle(titleText, for: .normal)
        }
    }

    @IBInspectable
    override var backgroundColor: UIColor? {
        didSet {
            self.setTitleColor(.white, for: .normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    private func setupButton() {
        self.setTitleColor(ProjectColor.buttonSelectedColor, for: .highlighted)
        self.titleLabel?.font = ProjectFont.PopinsRegular(14.0).font()
        self.heightAnchor.constraint(equalToConstant: 56).isActive = true
        self.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}
