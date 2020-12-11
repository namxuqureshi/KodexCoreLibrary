//
//  CustomDescriptionTV.swift
//  KodexCoreNetwork
//
//  Created by Jawad on 12/3/20.
//

import UIKit

open class CustomDescriptionTV: UIView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textView: UITextView!
    var view: UIView!
    // MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        setupView()
    }
    @IBInspectable
    open var setTitleLabel: String? {
        didSet{
            self.lblTitle.text = setTitleLabel!
        }
    }
    
    open var text: String{
        get{
            return self.textView.text!
        }
    }
    
    
    fileprivate var _fontSize:CGFloat = 18
    @IBInspectable
    var font:CGFloat
    {
        set
        {
            _fontSize = newValue
            self.textView.font = UIFont(name: _fontName, size: _fontSize)
        }
        get
        {
            return _fontSize
        }
    }
    
    fileprivate var _fontName:String = "Helvetica"
    @IBInspectable
    var fontName:String
    {
        set
        {
            _fontName = newValue
            self.textView.font = UIFont(name: _fontName, size: _fontSize)
        }
        get
        {
            return _fontName
        }
    }
    
    open var setFont : UIFont?{
        didSet{
            self.textField.font = setFont
        }
    }
    
    public func setText(text : String){
        self.textView.text = text
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
