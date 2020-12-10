//
//  SSCustomTabBar.swift
//  SSCustomTabBar
//
//  Created by Sumit Goswami on 27/03/19.
//  Copyright © 2019 SimformSolutions. All rights reserved.
//

import UIKit

public class SSCustomTabBar: UITabBar {
    
    
    /// Fill color of back wave layer
    @IBInspectable var layerFillColor: UIColor {
        get {
            return UIColor(cgColor: kLayerFillColor)
        }
        set{
            kLayerFillColor = newValue.cgColor
        }
    }
    
    
    /// Wave Height
    @IBInspectable var waveHeight: CGFloat {
        get{
            return self.minimalHeight
        }
        set{
            self.minimalHeight = newValue
        }
    }
    
    
    /// Unselected item tint color
    @IBInspectable var unselectedTabTintColor: UIColor {
        get {
            return self.unselectedItemTintColor ?? .black
        }
        set{
            self.unselectedItemTintColor = newValue
        }
    }
    
    
    private var kLayerFillColor: CGColor = UIColor.blue.cgColor
    private var displayLink: CADisplayLink!
    private let tabBarShapeLayer = CAShapeLayer()
    internal var minimalHeight: CGFloat = -30
    private var minimalY: CGFloat {
        get {
            return -minimalHeight
        }
    }
    var animating = false {
        didSet {
            self.isUserInteractionEnabled = !animating
            self.displayLink?.isPaused = !animating
        }
    }
    
    /// Controll point of wave
    
    private var leftPoint4 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            leftPoint4.backgroundColor = .clear
        }
    }
    private var leftPoint3 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            leftPoint3.backgroundColor = .clear
        }
    }
    private var leftPoint2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            leftPoint2.backgroundColor = .clear
        }
    }
    private var leftPoint1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            leftPoint1.backgroundColor = .clear
        }
    }
    private var centerPoint1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            centerPoint1.backgroundColor = .clear
        }
    }
    private var centerPoint2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            centerPoint2.backgroundColor = .clear
        }
    }
    private var rightPoint1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            rightPoint1.backgroundColor = .clear
        }
    }
    private var rightPoint2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            rightPoint2.backgroundColor = .clear
        }
    }
    private var rightPoint4 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            rightPoint4.backgroundColor = .clear
        }
    }
    
    // Point For Middle Always
    private var leftPointMid4 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            leftPointMid4.backgroundColor = .clear
        }
    }
    private var leftPointMid3 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            leftPointMid3.backgroundColor = .clear
        }
    }
    private var leftPointMid2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            leftPointMid2.backgroundColor = .clear
        }
    }
    private var leftPointMid1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            leftPointMid1.backgroundColor = .clear
        }
    }
    private var centerPointMid1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            centerPointMid1.backgroundColor = .clear
        }
    }
    private var centerPointMid2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            centerPointMid2.backgroundColor = .clear
        }
    }
    private var rightPointMid1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            rightPointMid1.backgroundColor = .clear
        }
    }
    private var rightPointMid2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            rightPointMid2.backgroundColor = .clear
        }
    }
    private var rightPointMid4 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            rightPointMid4.backgroundColor = .clear
        }
    }
    
    
    /// Draws the receiver’s image within the passed-in rectangle.
    ///
    /// - Parameter rect: rect of view
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setupTabBar()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: SSConstants.updateViewNotification)))
    }
    
}


// MARK: - Setup Tabbar
extension SSCustomTabBar {
    
    func setupTabBar() {
        self.isTranslucent = true
        self.backgroundColor = UIColor.clear
        self.backgroundImage = UIImage()
        self.shadowImage = UIImage()
        self.clipsToBounds = false
        
        /// Shadow
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = shadowColor?.cgColor
        self.layer.shadowOpacity = shadowOpacity//0.0//1.0
        
        self.addSubview(leftPoint4)
        self.addSubview(leftPoint3)
        self.addSubview(leftPoint2)
        self.addSubview(leftPoint1)
        self.addSubview(centerPoint1)
        self.addSubview(centerPoint2)
        self.addSubview(rightPoint1)
        self.addSubview(rightPoint2)
        self.addSubview(rightPoint4)
        //
        self.addSubview(leftPointMid4)
        self.addSubview(leftPointMid3)
        self.addSubview(leftPointMid2)
        self.addSubview(leftPointMid1)
        self.addSubview(centerPointMid1)
        self.addSubview(centerPointMid2)
        self.addSubview(rightPointMid1)
        self.addSubview(rightPointMid2)
        self.addSubview(rightPointMid4)
        self.displayLink = CADisplayLink(target: self, selector: #selector(updateShapeLayer))
        self.displayLink?.add(to: RunLoop.main, forMode: RunLoop.Mode.default)
        self.displayLink?.isPaused = true
        
        tabBarShapeLayer.frame = CGRect(x: 0.0, y: 0, width: self.bounds.width, height: self.bounds.height)
        tabBarShapeLayer.actions = ["position" : NSNull(), "bounds" : NSNull(), "path" : NSNull()]
        tabBarShapeLayer.fillColor = kLayerFillColor
        self.layer.insertSublayer(tabBarShapeLayer, at: 0)
        
        let width = UIScreen.main.bounds.width/CGFloat(self.items?.count ?? 0)
        if let selectedItem = self.selectedItem {
            let index = (self.items?.firstIndex(of: selectedItem) ?? 0)+1
            let changeValue = (width*(CGFloat(index)))-(width/2)
            self.setDefaultlayoutControlPoints(waveHeight: minimalHeight, locationX: changeValue)
//            index = 3
//            changeValue = (width*(CGFloat(index)))-(width/2)
//            self.setMiddlePointAbove(waveHeight: minimalHeight, locationX: changeValue)
            self.updateShapeLayer()
        }
    }
}



// MARK: - Set layer path
extension SSCustomTabBar {
    
    func setDefaultlayoutControlPoints(waveHeight: CGFloat, locationX: CGFloat) {
        
        let width = (UIScreen.main.bounds.width/CGFloat(self.items?.count ?? 0))
        leftPoint4.center = CGPoint(x: 0, y: minimalY+minimalHeight)
        rightPoint4.center = CGPoint(x: self.bounds.width, y: minimalY+minimalHeight)
        
        let imaganaeryFram = CGRect(x: locationX-(width/2), y: minimalY, width: width, height: minimalHeight)
        
        leftPoint3.center = CGPoint(x: imaganaeryFram.minX, y: imaganaeryFram.maxY)
        
        
        let topOffset: CGFloat = imaganaeryFram.width / 4.3
        let bottomOffset: CGFloat = imaganaeryFram.width / 4.5
        
        leftPoint2.center = CGPoint(x: imaganaeryFram.midX, y: imaganaeryFram.minY)
        leftPoint1.center = CGPoint(x: imaganaeryFram.minX + bottomOffset, y: imaganaeryFram.maxY)
        centerPoint1.center = CGPoint(x: imaganaeryFram.midX - topOffset, y: imaganaeryFram.minY)
        centerPoint2.center = CGPoint(x: imaganaeryFram.maxX, y: imaganaeryFram.maxY)
        rightPoint1.center = CGPoint(x: imaganaeryFram.midX + topOffset, y: imaganaeryFram.minY)
        rightPoint2.center = CGPoint(x: imaganaeryFram.maxX - bottomOffset, y: imaganaeryFram.maxY)
    }
    
    func setMiddlePointAbove(waveHeight: CGFloat, locationX: CGFloat) {
        
        let width = (UIScreen.main.bounds.width/CGFloat(self.items?.count ?? 0))
        leftPointMid4.center = CGPoint(x: 0, y: minimalY+minimalHeight)
        rightPointMid4.center = CGPoint(x: self.bounds.width, y: minimalY+minimalHeight)
        
        let imaganaeryFram = CGRect(x: locationX-(width/2), y: minimalY, width: width, height: minimalHeight)
        
        leftPointMid3.center = CGPoint(x: imaganaeryFram.minX, y: imaganaeryFram.maxY)
        
        
        let topOffset: CGFloat = imaganaeryFram.width / 4.3
        let bottomOffset: CGFloat = imaganaeryFram.width / 4.5
        
        leftPointMid2.center = CGPoint(x: imaganaeryFram.midX, y: imaganaeryFram.minY)
        leftPointMid1.center = CGPoint(x: imaganaeryFram.minX + bottomOffset, y: imaganaeryFram.maxY)
        centerPointMid1.center = CGPoint(x: imaganaeryFram.midX - topOffset, y: imaganaeryFram.minY)
        centerPointMid2.center = CGPoint(x: imaganaeryFram.maxX, y: imaganaeryFram.maxY)
        rightPointMid1.center = CGPoint(x: imaganaeryFram.midX + topOffset, y: imaganaeryFram.minY)
        rightPointMid2.center = CGPoint(x: imaganaeryFram.maxX - bottomOffset, y: imaganaeryFram.maxY)
    }
    
    
    /// updateShapeLayer
    @objc func updateShapeLayer() {
        tabBarShapeLayer.path = getCurrentPath()
    }
    
    
    /// Get path
    ///
    /// - Returns: get current index path
    func getCurrentPath() -> CGPath {
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0.0, y: UIScreen.main.bounds.height))
        bezierPath.addLine(to: CGPoint(x: 0.0, y: leftPoint4.viewCenter(usePresentationLayerIfPossible: animating).y))
        bezierPath.addLine(to: leftPoint3.viewCenter(usePresentationLayerIfPossible: animating))
        bezierPath.addCurve(
            to: leftPoint2.viewCenter(usePresentationLayerIfPossible: animating),
            controlPoint1: leftPoint1.viewCenter(usePresentationLayerIfPossible: animating),
            controlPoint2: centerPoint1.viewCenter(usePresentationLayerIfPossible: animating)
        )
        
        bezierPath.addCurve(
            to: centerPoint2.viewCenter(usePresentationLayerIfPossible: animating),
            controlPoint1: rightPoint1.viewCenter(usePresentationLayerIfPossible: animating),
            controlPoint2: rightPoint2.viewCenter(usePresentationLayerIfPossible: animating)
        )
        
        
        bezierPath.addLine(to: leftPoint3.viewCenter(usePresentationLayerIfPossible: animating))
        
        bezierPath.addLine(to: rightPoint4.viewCenter(usePresentationLayerIfPossible: animating))
        bezierPath.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height))
        
        //
//        bezierPath.move(to: CGPoint(x: 0.0, y: UIScreen.main.bounds.height))
//        bezierPath.addLine(to: CGPoint(x: 0.0, y: leftPointMid4.viewCenter(usePresentationLayerIfPossible: animating).y))
//        bezierPath.addLine(to: leftPointMid3.viewCenter(usePresentationLayerIfPossible: animating))
//        bezierPath.addCurve(
//            to: leftPointMid2.viewCenter(usePresentationLayerIfPossible: animating),
//            controlPoint1: leftPointMid1.viewCenter(usePresentationLayerIfPossible: animating),
//            controlPoint2: centerPointMid1.viewCenter(usePresentationLayerIfPossible: animating)
//        )
//        
//        bezierPath.addCurve(
//            to: centerPointMid2.viewCenter(usePresentationLayerIfPossible: animating),
//            controlPoint1: rightPointMid1.viewCenter(usePresentationLayerIfPossible: animating),
//            controlPoint2: rightPointMid2.viewCenter(usePresentationLayerIfPossible: animating)
//        )
//        
//        bezierPath.addLine(to: leftPointMid3.viewCenter(usePresentationLayerIfPossible: animating))
//        bezierPath.addLine(to: rightPointMid4.viewCenter(usePresentationLayerIfPossible: animating))
//        bezierPath.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height))
        
        bezierPath.close()
        return bezierPath.cgPath
    }
}
