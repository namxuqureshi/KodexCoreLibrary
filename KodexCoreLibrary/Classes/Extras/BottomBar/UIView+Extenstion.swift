//
//  UIView+Extenstion.swift
//  SSCustomTabBar
//
//  Created by Sumit Goswami on 27/03/19.
//  Copyright © 2019 SimformSolutions. All rights reserved.
//

import UIKit

//private var vBorderColour: UIColor = UIColor.white
//private var vCornerRadius: CGFloat = 0.0
//private var vBorderWidth: CGFloat = 0.0
//private var vMasksToBounds: Bool = true
private var vMakeCircle: Bool = false

extension UIView {
    var originOnWindow: CGPoint { return convert(CGPoint.zero, to: nil) }
}

extension NSLayoutConstraint{
    open func update(value : CGFloat , parent : UIView,duration: TimeInterval = 0.2) {
        self.constant = value
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            parent.layoutIfNeeded()
        }) { (animationCompleted: Bool) -> Void in
        }
    }
}
extension UIView {
    
    
    open func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    open func fadeIn(duration: TimeInterval = 0.2) {
        self.alpha = 0.0
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.alpha = 1.0
        }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    open func setBackground(color : UIColor){
        UIView.animate(withDuration: 0.3, delay: 0.0, options:[.autoreverse], animations: {
               self.backgroundColor = color
           }, completion:nil)
    }
    
   open func fadeOutHide(duration: TimeInterval = 0.2) {
        self.alpha = 1.0
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.alpha = 0.0
        }) { (animationCompleted: Bool) -> Void in
        }
    }
    /**
     Simply zooming in of a view: set view scale to 0 and zoom to Identity on 'duration' time interval.
     - parameter duration: animation duration
     */
   open func zoomIn(_ duration: TimeInterval = 0.2) {
        self.isHidden = false
        self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform.identity
        }) { (animationCompleted: Bool) -> Void in
        }
    }
    
   open  func Blinking(duration: TimeInterval = 0.8) {
        let alpha = self.alpha
        if alpha == 1.0 {
            self.alpha = 1.0
        }else{
            self.alpha = 0.1
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            if alpha == 1.0 {
                self.alpha = 0.1
            }else{
                self.alpha = 1.0
            }
        }) { (animationCompleted: Bool) -> Void in
            self.Blinking()
        }
    }
    /**
     Simply zooming out of a view: set view scale to Identity and zoom out to 0 on 'duration' time interval.
     - parameter duration: animation duration
     */
   open  func zoomOut(_ duration: TimeInterval = 0.2) {
        self.transform = CGAffineTransform.identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        }) { (animationCompleted: Bool) -> Void in
            self.isHidden = true
        }
    }
    
    open func zoomInImage(duration: TimeInterval = 0.2) {
        self.isHidden = false
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform.identity
        }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = (delegate as! CAAnimationDelegate)
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    
    func shake(count : Float? = nil,for duration : TimeInterval? = nil,withTanslation translation : Float? = nil) {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        animation.repeatCount = count ?? 2
        animation.duration = (duration ?? 0.5)/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation ?? -5
        layer.add(animation, forKey: "shake")
    }
    static func loadFromXib<T>(withOwner: Any? = nil, options: [AnyHashable : Any]? = nil) -> T where T: UIView
    {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: withOwner, options: (options as? [UINib.OptionsKey : Any])).first as? T else {
            fatalError("Could not load view from nib file.")
        }
        return view
    }
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func bounceAnimationView(){
        let bounceAnimation = CAKeyframeAnimation(keyPath: AnimationConstants.AnimationKeys.Scale)
        bounceAnimation.values = [1.0, 1.1, 1.0, 1.0, 1.0, 1.0, 1.0]
        bounceAnimation.duration = TimeInterval(0.6)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
//        round(corners: [.bottomLeft,.bottomLeft,.topLeft,.topRight], radius: <#T##CGFloat#>)
        self.layer.add(bounceAnimation, forKey: nil)
    }
    
    func round(corners: UIRectCorner, cornerRadius: Double) {
        
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    func keepCenterAndApplyAnchorPoint(_ point: CGPoint) {
        
        guard layer.anchorPoint != point else { return }
        
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var c = layer.position
        c.x -= oldPoint.x
        c.x += newPoint.x
        
        c.y -= oldPoint.y
        c.y += newPoint.y
        
        layer.position = c
        layer.anchorPoint = point
    }
    
    func viewCenter(usePresentationLayerIfPossible: Bool) -> CGPoint {
        if usePresentationLayerIfPossible, let presentationLayer = layer.presentation() {
            return presentationLayer.position
        }
        return center
    }
    
    var screenWidth:CGFloat {
        get {
            DataManager.sharedInstance.getScreenWidth()//return UIScreen.main.bounds.height
        }
        set(newValue) {
            DataManager.sharedInstance.setScreenWidth(value: newValue)
        }
    }
    
    var screenHeight:CGFloat {
        get {
            DataManager.sharedInstance.getScreenHeight()//return UIScreen.main.bounds.height
        }
        set(newValue) {
            DataManager.sharedInstance.setScreenHeight(value: newValue)
        }
    }
    
    func hideView(){
        self.isHidden = true
    }
    
    func showView(){
        self.isHidden = false
    }
    
    
    
    
    //MARK: Set multi Color text
    func  setAttributedTextForLabelAll(mainString : String? , attributedStringsArray : [String?]  , color : [UIColor?], attFont:[UIFont?]) {
        let attributedString1    = NSMutableAttributedString(string: mainString ?? "")
        for (index,objStr) in attributedStringsArray.enumerated() {
            let range1 = (mainString as NSString?)?.range(of: objStr ?? "") ?? .init()
            let attribute_font = [NSAttributedString.Key.font: attFont[index] ?? UIFont.systemFont(ofSize: CGFloat(12))]
            attributedString1.addAttributes(attribute_font, range:  range1)
            attributedString1.addAttribute(NSAttributedString.Key.foregroundColor, value: color[index] ?? UIColor.clear, range: range1)
        }
        if(self.isKind(of: UILabel.self)) {
            (self as! UILabel).attributedText = attributedString1
        }
        if(self.isKind(of: UITextView.self)) {
            (self as! UITextView).attributedText = attributedString1
        }
        if(self.isKind(of: UITextField.self)) {
            (self as! UITextField).attributedText = attributedString1
        }
        if(self.isKind(of: UIButton.self)) {
            (self as! UIButton).setAttributedTitle(attributedString1, for: .normal)
        }
    }
    
    enum AnimationKeyPath: String {
        case opacity = "opacity"
    }
    
    func flash(animation: AnimationKeyPath ,withDuration duration: TimeInterval = 0.5, repeatCount: Float = 5){
        let flash = CABasicAnimation(keyPath: AnimationKeyPath.opacity.rawValue)
        flash.duration = duration
        flash.fromValue = 1 // alpha
        flash.toValue = 0 // alpha
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = repeatCount
        
        layer.add(flash, forKey: nil)
    }
    
    func fadeInNew(_ duration: TimeInterval = 0.7,_ delay: TimeInterval = 0.7) {
        UIView.animate(withDuration: duration, delay: delay, options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat], animations: {
            self.alpha = 0.7
        }, completion: { isDone in
            self.fadeOutNew()
        })
    }
    
    func fadeOutNew(_ duration: TimeInterval = 0.7,_ delay: TimeInterval = 0.7) {
        UIView.animate(withDuration: duration, delay: delay, options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat], animations: {
            self.alpha = 1
        }, completion: { isDone in
            self.fadeInNew()
        })
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius//vCornerRadius
        }
        set {
            layer.cornerRadius = newValue
//            vCornerRadius = newValue
            self.setNeedsLayout()
            
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth//vBorderWidth
        }
        set {
            layer.borderWidth = newValue
//            vBorderWidth = newValue
            self.setNeedsLayout()
            
        }
    }
    
    @IBInspectable var masksToBounds: Bool {
        get {
            return layer.masksToBounds//vMasksToBounds
        }
        set {
            layer.masksToBounds = newValue
//            vMasksToBounds = newValue
            self.setNeedsLayout()
            
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get{
            
            return UIColor.init(cgColor: layer.borderColor ?? UIColor.clear.cgColor)//vBorderColour
        }
        set {
            
            layer.borderColor = newValue?.cgColor
//            vBorderColour = newValue
            self.setNeedsLayout()
            
        }
    }
    
    @IBInspectable var makeCircle: Bool {
        get{
            
            return vMakeCircle
        }
        set {
            
            if newValue  {
                cornerRadius = frame.size.width / 2
                masksToBounds = true
            }
            else    {
                cornerRadius = 0//vCornerRadius
                masksToBounds = vMakeCircle
            }
            vMakeCircle = newValue
            self.setNeedsLayout()
            
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
                self.setNeedsLayout()
            }
        }
    }
    
    func centerInSuperview() {
        self.centerHorizontallyInSuperview()
        self.centerVerticallyInSuperview()
        self.setNeedsLayout()
        
    }
    func equalAndCenterToSupper() {
        
        self.centerHorizontallyInSuperview()
        self.centerVerticallyInSuperview()
        leadingInSuperview()
        trailingInSuperview()
        topInSuperview()
        bottomInSuperview()
        self.setNeedsLayout()
        
        
    }
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat)
    {
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    func centerHorizontallyInSuperview(){
        let c: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.superview, attribute: .centerX, multiplier: 1, constant: 0)
        self.superview?.addConstraint(c)
    }
    
    func centerVerticallyInSuperview(){
        let c: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: self.superview, attribute: .centerY, multiplier: 1, constant: 0)
        self.superview?.addConstraint(c)
    }
    func leadingInSuperview(){
        let c: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute:.leadingMargin, relatedBy: .equal, toItem: self.superview, attribute: .centerY, multiplier: 1, constant: 0)
        self.superview?.addConstraint(c)
    }
    func trailingInSuperview(){
        let c: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute:.trailingMargin, relatedBy: .equal, toItem: self.superview, attribute: .centerY, multiplier: 1, constant: 0)
        self.superview?.addConstraint(c)
    }
    func topInSuperview(){
        let c: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute:.topMargin, relatedBy: .equal, toItem: self.superview, attribute: .centerY, multiplier: 1, constant: 0)
        self.superview?.addConstraint(c)
    }
    func bottomInSuperview(){
        let c: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute:.bottomMargin, relatedBy: .equal, toItem: self.superview, attribute: .centerY, multiplier: 1, constant: 0)
        self.superview?.addConstraint(c)
    }
    
    class func fromNib<T : UIView>() -> T {
        
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    
}



struct AnimationConstants {
    
    struct AnimationKeys {
        
        static let Scale = "transform.scale"
        static let Rotation = "transform.rotation"
        static let KeyFrame = "contents"
        static let PositionY = "position.y"
        static let Opacity = "opacity"
    }
}
