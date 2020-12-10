//
//  UILabelExtensions.swift
//  Duet
//
//  Created by Jassie on 8/6/19.
//  Copyright © 2019 
//

import UIKit

extension UILabel{
    func setSavedTextTitle(name : String , isSaved : Bool = false) {
        if(!isSaved){
            self.string = name
        }else{
            let attributedString = NSMutableAttributedString(string: name)
            let jeansAttachment = NSTextAttachment()
            jeansAttachment.image = #imageLiteral(resourceName: "pin_red")
            jeansAttachment.bounds = CGRect(x: 6, y: 0, width: 16, height: 16)
            attributedString.append(NSAttributedString(attachment: jeansAttachment))
            self.attributedText = attributedString
        }
        
    }
}
