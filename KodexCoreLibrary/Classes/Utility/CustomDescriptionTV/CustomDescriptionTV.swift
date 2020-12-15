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
        set{
            self.textView.text = newValue
        }
        get{
            return self.textView.text!
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
        self.textView.font = ProjectFont.PopinsRegular(16.0).font()
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
