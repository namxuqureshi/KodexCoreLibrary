//
//  CustomeEmailTF.swift
//  KodexCoreNetwork
//
//  Created by Jawad on 11/26/20.
//

import UIKit
import DropDown

public protocol CustomPickerTFDelegate: class {
    func emailDidBeginEditing(_ textField: UITextField)
    func emailDidEndEditing(_ textField: UITextField)
    func textFieldDidChanged(replacementString string: String)
}

public protocol CustomPickerDelegate: class {
    func onUpdateValue(index : Int, value : String)
}

open class CustomPickerTF: UIView  {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tickImgWidth: NSLayoutConstraint!
    @IBOutlet weak var tickImage: UIImageView!
    @IBOutlet weak var contentView: UIView!
    let dropDown = DropDown()
    var view: UIView!
    var isEmailValid : Bool = false
    var matchedString : String?
    public var delegateTextField : CustomPickerTFDelegate?
    public var delegate : CustomPickerDelegate?
    // MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        setupView()
    }
    
    @IBInspectable
    open var placeholderText: String? {
        didSet{
            self.textField.placeholder = placeholderText!
        }
    }
    
    public func setText(text : String){
        self.textField.text = text
    }
    
    public var dataSourse : [String]? = [String](){
        didSet{
            dropDown.dataSource = dataSourse!
        }
    }
    public func setMatchedString(s : String){
        self.matchedString = s
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
        self.textField.placeholder = placeholderText
        setupDropDown()
    }
    
    public func setError(){
        self.contentView.borderWidth = 1
        self.contentView.borderColor = ProjectColor.redColor
    }
    
    public func removeError(){
        self.contentView.borderWidth = 0
        self.contentView.borderColor = .clear
    }
    
    func setupDropDown(){
        dropDown.direction = .bottom
        dropDown.dataSource = dataSourse!
        dropDown.dismissMode = .automatic
        dropDown.bottomOffset = CGPoint(x: 0, y:40)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.textField.text = item
            delegate?.onUpdateValue(index: index, value: item)
        }
    }
    
    @IBAction func onClickPicker(_ sender : UIButton){
        self.dropDown.anchorView = self
        self.dropDown.show()
    }
}

extension CustomPickerTF : UITextFieldDelegate{
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegateTextField?.emailDidBeginEditing(textField)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegateTextField?.emailDidEndEditing(textField)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text! + string
        if self.contentView.borderWidth == 1 {
            self.removeError()
        }
        delegateTextField?.textFieldDidChanged(replacementString: text)
        return true
    }
}
