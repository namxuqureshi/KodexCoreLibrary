//
//  HeaderView.swift
//  KodexCoreNetwork
//
//  Created by Jawad on 11/27/20.
//

import UIKit

public protocol HeaderViewDelegate{
    func onMenuBtnClick(isMenu : Bool)
    func onNotificationClick()
    func onProfileClick()
}
open class HeaderView: UIView {
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var profileVView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    open var delegate : HeaderViewDelegate?
    var view: UIView!
    open var isBackEnabled : Bool? = false {
        didSet{
            self.notificationView.isHidden = isBackEnabled!
            self.profileVView.isHidden = isBackEnabled!
            self.btnMenu.setImage(UIImage.init(named: "backButton"), for: .normal)
        }
    }
    
    open var titleText : String? = "Dashboard" {
        didSet{
            self.lblTitle.text = titleText
        }
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
    
    public func setupView(){
        self.view.bounceAnimationView()
        if let img  =  DataManager.sharedInstance.profileImage{
            self.imgView.loadGif(url: URL.init(string: img), placeholder: PlaceHolder.ImageDefault)
        }
    }
    
    @IBAction func onClickMenu(_ sender : UIButton){
        sender.bounceAnimationView()
        delegate?.onMenuBtnClick(isMenu: !self.isBackEnabled!)
    }
    
    @IBAction func onClickProfile(_ sender : UIButton){
        sender.bounceAnimationView()
        delegate?.onProfileClick()
    }
    
    @IBAction func onClickNotification(_ sender : UIButton){
        sender.bounceAnimationView()
        delegate?.onNotificationClick()
       
       
    }
    
}
