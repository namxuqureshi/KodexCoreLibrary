//
//  UITextField+Extension.swift
//  LFW
//
//  Created by J Aiden on 25/05/2018.
//  Copyright © 2018 
//

import Foundation
import MaterialComponents
import UIKit


extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

extension UIButton{
    
    func setBackgroundView(view: UIView) {
        view.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        view.isUserInteractionEnabled = false
        self.addSubview(view)
    }
}

protocol LinkedLabelDelegate:class {
    func openWebViewAc(link:String)
}

class LinkedLabel: UILabel {
    
    fileprivate let layoutManager = NSLayoutManager()
    fileprivate let textContainer = NSTextContainer(size: CGSize.zero)
    fileprivate var textStorage: NSTextStorage?
    var delegateLink:LinkedLabelDelegate?
    
    override init(frame aRect:CGRect){
        super.init(frame: aRect)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LinkedLabel.handleTapOnLabel))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    override var attributedText: NSAttributedString?{
        didSet{
            if let _attributedText = attributedText{
                self.textStorage = NSTextStorage(attributedString: _attributedText)
                
                self.layoutManager.addTextContainer(self.textContainer)
                self.textStorage?.addLayoutManager(self.layoutManager)
                
                self.textContainer.lineFragmentPadding = 0.0;
                self.textContainer.lineBreakMode = self.lineBreakMode;
                self.textContainer.maximumNumberOfLines = self.numberOfLines;
            }
            
        }
    }
    
    @objc func handleTapOnLabel(tapGesture:UITapGestureRecognizer){
        
        let locationOfTouchInLabel = tapGesture.location(in: tapGesture.view)
        let labelSize = tapGesture.view?.bounds.size
        let textBoundingBox = self.layoutManager.usedRect(for: self.textContainer)
        let textContainerOffset = CGPoint(x: ((labelSize?.width)! - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: ((labelSize?.height)! - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = self.layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: self.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        
        self.attributedText?.enumerateAttribute(NSAttributedString.Key.link, in: NSMakeRange(0, (self.attributedText?.length)!), options: NSAttributedString.EnumerationOptions(rawValue: UInt(0)), using:{
            (attrs: Any?, range: NSRange, stop: UnsafeMutablePointer<ObjCBool>) in
            
            if NSLocationInRange(indexOfCharacter, range){
                if let _attrs = attrs{
                    self.delegateLink?.openWebViewAc(link: _attrs as! String)
                    //                    UIApplication.shared.openURL(URL(string: _attrs as! String)!)
                }
            }
        })
        
    }
    
}


@IBDesignable  // Lets you change a UIView instance in storyboard to this class, so you can visualize it and add constraints to it
class FloatingPlaceholderTextField: UIView,UITextFieldDelegate{
    
    private var textInput: MDCTextField!
    private var controller: MDCTextInputControllerOutlined!
    private let textColor = UIColor(named: "textColor")
    
    private var placeholderText = ""
    //@IBDesignable lets you modify an instance of this element in the main.storyboard
    @IBInspectable var setPlaceholderText: String{
        get{
            return self.placeholderText
        }
        set(str){
            self.placeholderText = str
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupInputView()
        setupContoller()
        
    }
    private func setupContoller(){
        // MARK: Text Input Controller Setup
        
        // Step 1
        if(controller != nil){return}
        controller = MDCTextInputControllerOutlined(textInput: textInput)
        
        // Step 2
        controller.activeColor = textColor
        controller.normalColor = textColor
        controller.textInput?.textColor = textColor
        controller.inlinePlaceholderColor = textColor
        controller.textInputFont = UIFont.systemFont(ofSize: CGFloat(14))
        controller.inlinePlaceholderFont = UIFont.systemFont(ofSize: CGFloat(14))
        controller.leadingUnderlineLabelFont = UIFont.systemFont(ofSize: CGFloat(14))
        controller.trailingUnderlineLabelFont = UIFont.systemFont(ofSize: CGFloat(14))
        controller.floatingPlaceholderActiveColor = textColor
        controller.floatingPlaceholderNormalColor = textColor
        controller.borderRadius = 10
        
        
    }
    private func setupInputView(){
        //MARK: Text Input Setup
        if let _ = self.viewWithTag(1){return}
        // Step 1
        textInput = MDCTextField.init()
        
        // Step 2
        textInput.tag = 1
        
        // Step 3
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.font = UIFont.systemFont(ofSize: CGFloat(14))
        // Step 4
        
        self.addSubview(textInput)
        textInput.cornerRadius = 10
        
        // Step 5
        textInput.placeholder = placeholderText
        
        // Step 6
        textInput.delegate = self
        
        // Step 7
        textInput.textColor = textColor
        
        // Step 8
        NSLayoutConstraint.activate([
            (textInput.topAnchor.constraint(equalTo: self.topAnchor)),
            (textInput.bottomAnchor.constraint(equalTo: self.bottomAnchor)),
            (textInput.leadingAnchor.constraint(equalTo: self.leadingAnchor)),
            (textInput.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        ])
    }
    
}
