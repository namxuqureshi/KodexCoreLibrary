//
//  CheckBox.swift
//  KodexCoreNetwork
//
//  Created by Jawad on 11/26/20.
//

import UIKit

open class CheckBox: UIView {
    var isChecked : Bool = false
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var box: UIView!
    @IBOutlet weak var tickImage: UIImageView!
    var selectedColor : UIColor?
    @IBInspectable
    var setSelectedColor: UIColor? {
        didSet{
            self.selectedColor = setSelectedColor
        }
    }
    
    @IBInspectable
    var setDefaultChecked: CFBoolean? {
        didSet{
            self.isChecked = setDefaultChecked! as! Bool
        }
    }
    
    @IBInspectable
    var setTitle: String? {
        didSet{
            self.lbl.text = setTitle
        }
    }
    
    var unSelectedColor : UIColor?
    @IBInspectable
    var setUnSelectedColor: UIColor? {
        didSet{
            self.unSelectedColor = setUnSelectedColor
        }
    }
    var view: UIView!
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
     
    }
    
    
    @IBAction func onClickCheckBox(_ sender: Any) {
        if isChecked{
            self.isChecked = false
            self.tickImage.isHidden = true
            self.box.borderWidth = 2
            self.box.backgroundColor = UIColor.clear
        }else{
            self.isChecked = true
            self.tickImage.isHidden = false
            self.box.borderWidth = 0
            self.box.backgroundColor = ProjectColor.buttonColor
        }
    }
    
}
