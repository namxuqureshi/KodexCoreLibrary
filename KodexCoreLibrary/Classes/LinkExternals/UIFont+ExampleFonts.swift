//
//  UIFont+ExampleFonts.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit
private var lblLineSpace: CGFloat = 0.0
private var btnLineSpace: CGFloat = 0.0
private var txtLineSpace: CGFloat = 0.0

extension UIFont {
    
    class func exampleAvenirMedium(ofSize size: CGFloat) -> UIFont {
        return  UIFont.systemFont(ofSize: size, weight: .bold)

    }
    
    class func exampleexampleAvenirBold(ofSize size: CGFloat) -> UIFont {
        return  UIFont.boldSystemFont(ofSize:size)    }
    
    class func exampleAvenirLight(ofSize size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }

}

extension UILabel{
    @IBInspectable var setLineSpacing: CGFloat{
        get {
            return lblLineSpace
        }
        set {
            let textString = NSMutableAttributedString(string: self.text!)
            let textRange = NSRange(location: 0, length: textString.length)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = newValue
            textString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range: textRange)
            textString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: textRange)
            self.attributedText = textString
            lblLineSpace = newValue
            self.setNeedsLayout()
            
        }
    }
}

extension UIButton{
    @IBInspectable var setLineSpacingButton: CGFloat{
        get {
            return btnLineSpace
        }
        set {
            let textString = NSMutableAttributedString(string: self.titleLabel!.text!)
            let textRange = NSRange(location: 0, length: textString.length)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = newValue
            textString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range: textRange)
            textString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: textRange)
            self.titleLabel!.attributedText = textString
            btnLineSpace = newValue
            self.setNeedsLayout()
            
        }
    }
}

extension UITextView{
    @IBInspectable var setLineSpacingButton: CGFloat{
        get {
            return txtLineSpace
        }
        set {
            let textString = NSMutableAttributedString(string: self.text!)
            let textRange = NSRange(location: 0, length: textString.length)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = newValue
            textString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range: textRange)
            textString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: textRange)
            self.attributedText = textString
            txtLineSpace = newValue
            self.setNeedsLayout()
            
        }
    }
}

extension UILabel {
    func setTextColorToGradient(image: UIImage) {
        UIGraphicsBeginImageContext(frame.size)
        image.draw(in: bounds)
        let myGradient = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.textColor = UIColor(patternImage: myGradient!)
    }
}

extension UITextField {
    func setTextColorToGradient(image: UIImage) {
        UIGraphicsBeginImageContext(frame.size)
        image.draw(in: bounds)
        let myGradient = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.textColor = UIColor(patternImage: myGradient!)
       
        
    }

    
}


