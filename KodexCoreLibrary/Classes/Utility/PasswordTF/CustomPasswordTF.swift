//
//  CustomePasswordTF.swift
//  KodexCoreNetwork
//
//  Created by Jawad on 11/26/20.
//

import UIKit
public protocol CustomPasswordTFDelegate: class {
    func emailDidBeginEditing(_ textField: UITextField)
    func emailDidEndEditing(_ textField: UITextField)
    func textFieldDidChanged(replacementString string: String)
}

open class CustomPasswordTF: UIView {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var btnVissible: UIButton!
    @IBOutlet weak var imageVissible: UIImageView!
    @IBOutlet weak var contentView: UIView!
    var view: UIView!
    var isVissible : Bool = false
    public var delegate : CustomPasswordTFDelegate?
    private var selectedImage : UIImage?
    private var unSelectedImage : UIImage?
    @IBInspectable
    open var placeholder: String? {
        didSet {
            self.textField.placeholder = placeholder ?? "Password"
        }
    }
    
    @IBInspectable
    var setSelectedImage: UIImage? {
        didSet{
            self.selectedImage = setSelectedImage
        }
    }
    
    open var text: String{
        get{
            return self.textField.text!
        }
        set{
            self.textField.text! = newValue
        }
    }
    
    @IBInspectable
    var setUnSelectedImage: UIImage? {
        didSet{
            self.unSelectedImage = setUnSelectedImage
        }
    }
    
    open func setText(text : String){
        self.textField.text = text
    }
    // MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
        setupView()
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        self.view = view
    }
    
    private func setupView(){
        self.textField.font = ProjectFont.PopinsRegular(16.0).font()
        self.textField.delegate = self
        self.textField.placeHolderColor = ProjectColor.placeholderColor
        if (self.placeholder ?? "").isEmpty{
            self.textField.placeholder = "Password"
        }else{
            self.textField.placeholder = self.placeholder
        }
    }
    
    @IBAction func onClickVissible(_ sender: Any) {
        if isVissible{
            self.textField.isSecureTextEntry = true
            isVissible = false
            self.btnVissible.setImage(self.unSelectedImage, for: .normal)
            self.btnVissible.clipsToBounds = true
        }else{
            self.textField.isSecureTextEntry = false
            isVissible = true
            self.btnVissible.setImage(self.selectedImage, for: .normal)
            self.btnVissible.clipsToBounds = true
        }
    }
    
    public func setError(){
        self.contentView.borderWidth = 1
        self.contentView.borderColor = ProjectColor.redColor
    }
    
    public func removeError(){
        self.contentView.borderWidth = 0
        self.contentView.borderColor = .clear
    }
    
}

extension CustomPasswordTF : UITextFieldDelegate{
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.emailDidBeginEditing(textField)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.emailDidEndEditing(textField)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text! + string
        if text.count > 1{
            self.imageVissible.isHidden = false
            self.btnVissible.isHidden = false
            if isVissible{
                self.btnVissible.setImage(self.selectedImage, for: .normal)
            }else{
                self.btnVissible.setImage(self.unSelectedImage, for: .normal)
            }
           
        }else{
            self.imageVissible.isHidden = true
            self.btnVissible.isHidden = true
        }
        if self.contentView.borderWidth == 1 {
            self.removeError()
        }
        delegate?.textFieldDidChanged(replacementString: text)
        return true
    }
}
