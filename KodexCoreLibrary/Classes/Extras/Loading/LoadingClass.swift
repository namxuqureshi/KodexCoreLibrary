//
//  LoadingClass.swift
//  Trecco
//
//  Created by J Aiden on 3/10/20.
//  Copyright © 2020 
//

import Foundation

import UIKit

//MARK: AASquareLoadingInterface
/**
 Interface for the AASquareLoading class
 */
public protocol AASquareLoadingInterface: class {
    var color : UIColor { get set }
    var backgroundColor : UIColor? { get set }
    
    func start(_ delay : TimeInterval)
    func stop(_ delay : TimeInterval)
    func setSquareSize(_ size: Float)
}

private var AASLAssociationKey: UInt8 = 0

//MARK: UIView extension
public extension UIView {
    
    /**
     Variable to allow access to the class AASquareLoading
     */
    var squareLoading: AASquareLoadingInterface {
        get {
            if let value = objc_getAssociatedObject(self, &AASLAssociationKey) as? AASquareLoadingInterface {
                return value
            } else {
                let squareLoading = AASquaresLoading(target: self)
                
                objc_setAssociatedObject(self, &AASLAssociationKey, squareLoading,
                                         objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
                
                return squareLoading
            }
        }
        
        set {
            objc_setAssociatedObject(self, &AASLAssociationKey, newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

//MARK: AASquareLoading class
/**
 Main class AASquareLoading
 */
open class AASquaresLoading : UIView, AASquareLoadingInterface, CAAnimationDelegate {
    open var view : UIView = UIView()
    fileprivate(set) open var size : Float = 0
    open var color : UIColor = UIColor(red: 0, green: 0.48, blue: 1, alpha: 1) {
        didSet {
            for layer in squares {
                layer.backgroundColor = color.cgColor
            }
        }
    }
    open var parentView : UIView?
    
    fileprivate var squareSize: Float?
    fileprivate var gapSize: Float?
    fileprivate var moveTime: Float?
    fileprivate var squareStartX: Float?
    fileprivate var squareStartY: Float?
    fileprivate var squareStartOpacity: Float?
    fileprivate var squareEndX: Float?
    fileprivate var squareEndY: Float?
    fileprivate var squareEndOpacity: Float?
    fileprivate var squareOffsetX: [Float] = [Float](repeating: 0, count: 9)
    fileprivate var squareOffsetY: [Float] = [Float](repeating: 0, count: 9)
    fileprivate var squareOpacity: [Float] = [Float](repeating: 0, count: 9)
    fileprivate var squares : [CALayer] = [CALayer]()
    
    public init(target: UIView) {
        super.init(frame: target.frame)
        
        parentView = target
        setup(self.size)
    }
    
    public init(target: UIView, size: Float) {
        super.init(frame: target.frame)
        
        parentView = target
        setup(size)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup(0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup(0)
    }
    
    open override func layoutSubviews() {
        updateFrame()
        super.layoutSubviews()
    }
    
    fileprivate func setup(_ size: Float) {
        self.size = size
        updateFrame()
        self.initialize()
    }
    
    fileprivate func updateFrame() {
        if parentView != nil {
            self.frame = CGRect(x: 0, y: 0, width: parentView!.frame.width, height: parentView!.frame.height)
        }
        if size == 0 {
            let width = frame.size.width
            let height = frame.size.height
            size = width > height ? Float(height/8) : Float(width/8)
        }
        self.view.frame = CGRect(x: frame.width / 2 - CGFloat(size) / 2,
                                 y: frame.height / 2 - CGFloat(size) / 2, width: CGFloat(size), height: CGFloat(size))
    }
    
    /**
     Function to start the loading animation
     
     - Parameter delay : The delay before the loading start
     */
    open func start(_ delay : TimeInterval = 0.0) {
        if (parentView != nil) {
            self.layer.opacity = 0
            self.parentView!.addSubview(self)
            UIView.animate(withDuration: 0.6, delay: delay, options: UIView.AnimationOptions(),
                           animations: { () -> Void in
                            self.layer.opacity = 1
            }, completion: nil)
        }
    }
    
    /**
     Function to start the loading animation
     
     - Parameter delay : The delay before the loading start
     */
    open func stop(_ delay : TimeInterval = 0.0) {
        if (parentView != nil) {
            self.layer.opacity = 1
            UIView.animate(withDuration: 0.6, delay: delay, options: UIView.AnimationOptions(),
                           animations: { () -> Void in
                            self.layer.opacity = 0
            }, completion: { (success: Bool) -> Void in
                self.removeFromSuperview()
            })
        }
    }
    
    open func setSquareSize(_ size: Float) {
        self.view.layer.sublayers = nil
        setup(size)
    }
    
    fileprivate func initialize() {
        let gap : Float = 0.04
        gapSize = size * gap
        squareSize = size * (1.0 - 2 * gap) / 3
        moveTime = 0.15
        squares = [CALayer]()
        
        self.addSubview(view)
        if (self.backgroundColor == nil) {
            self.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        }
        for i : Int in 0 ..< 3 {
            for j : Int in 0 ..< 3 {
                var offsetX, offsetY : Float
                let idx : Int = 3 * i + j
                if i == 1 {
                    offsetX = squareSize! * (2 - Float(j)) + gapSize! * (2 - Float(j))
                    offsetY = squareSize! * Float(i) + gapSize! * Float(i)
                } else {
                    offsetX = squareSize! * Float(j) + gapSize! * Float(j)
                    offsetY = squareSize! * Float(i) + gapSize! * Float(i)
                }
                squareOffsetX[idx] = offsetX
                squareOffsetY[idx] = offsetY
                squareOpacity[idx] = 0.1 * (Float(idx) + 1)
            }
        }
        squareStartX = squareOffsetX[0]
        squareStartY = squareOffsetY[0] - 2 * squareSize! - 2 * gapSize!
        squareStartOpacity = 0.0
        squareEndX = squareOffsetX[8]
        squareEndY = squareOffsetY[8] + 2 * squareSize! + 2 * gapSize!
        squareEndOpacity = 0.0
        
        for i in -1 ..< 9 {
            self.addSquareAnimation(i)
        }
    }
    
    fileprivate func addSquareAnimation(_ position: Int) {
        let square : CALayer = CALayer()
        if position == -1 {
            square.frame = CGRect(x: CGFloat(squareStartX!), y: CGFloat(squareStartY!),
                                  width: CGFloat(squareSize!), height: CGFloat(squareSize!))
            square.opacity = squareStartOpacity!
        } else {
            square.frame = CGRect(x: CGFloat(squareOffsetX[position]),
                                  y: CGFloat(squareOffsetY[position]), width: CGFloat(squareSize!), height: CGFloat(squareSize!))
            square.opacity = squareOpacity[position]
        }
        square.backgroundColor = self.color.cgColor
        squares.append(square)
        self.view.layer.addSublayer(square)
        
        var keyTimes = [Float]()
        var alphas = [Float]()
        keyTimes.append(0.0)
        if position == -1 {
            alphas.append(0.0)
        } else {
            alphas.append(squareOpacity[position])
        }
        if position == 0 {
            square.opacity = 0.0
        }
        
        let sp : CGPoint = square.position
        let path : CGMutablePath = CGMutablePath()
        
        path.move(to: CGPoint(x: sp.x, y: sp.y))
        
        var x, y, a : Float
        if position == -1 {
            x = squareOffsetX[0] - squareStartX!
            y = squareOffsetY[0] - squareStartY!
            a = squareOpacity[0]
        } else if position == 8 {
            x = squareEndX! - squareOffsetX[position]
            y = squareEndY! - squareOffsetY[position]
            a = squareEndOpacity!
        } else {
            x = squareOffsetX[position + 1] - squareOffsetX[position]
            y = squareOffsetY[position + 1] - squareOffsetY[position]
            a = squareOpacity[position + 1]
        }
        path.addLine(to: CGPoint(x: sp.x + CGFloat(x), y: sp.y + CGFloat(y)))
        keyTimes.append(1.0 / 8.0)
        alphas.append(a)
        
        path.addLine(to: CGPoint(x: sp.x + CGFloat(x), y: sp.y + CGFloat(y)))
        keyTimes.append(1.0)
        alphas.append(a)
        
        let posAnim : CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        posAnim.isRemovedOnCompletion = false
        posAnim.duration = Double(moveTime! * 8)
        posAnim.path = path
        posAnim.keyTimes = keyTimes as [NSNumber]?
        
        let alphaAnim : CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "opacity")
        alphaAnim.isRemovedOnCompletion = false
        alphaAnim.duration = Double(moveTime! * 8)
        alphaAnim.values = alphas
        alphaAnim.keyTimes = keyTimes as [NSNumber]?
        
        let blankAnim : CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "opacity")
        blankAnim.isRemovedOnCompletion = false
        blankAnim.beginTime = Double(moveTime! * 8)
        blankAnim.duration = Double(moveTime!)
        blankAnim.values = [0.0, 0.0]
        blankAnim.keyTimes = [0.0, 1.0]
        
        var beginTime : Float
        if position == -1 {
            beginTime = 0
        } else {
            beginTime = moveTime! * Float(8 - position)
        }
        let group : CAAnimationGroup = CAAnimationGroup()
        group.animations = [posAnim, alphaAnim, blankAnim]
        group.beginTime = CACurrentMediaTime() + Double(beginTime)
        group.repeatCount = HUGE
        group.isRemovedOnCompletion = false
        group.delegate = self
        group.duration = Double(9 * moveTime!)
        
        square.add(group, forKey: "square-\(position)")
    }
}

// MARK: PopOver Things
public protocol KUIPopOverUsable {
    
    var contentSize: CGSize { get }
    var contentView: UIView { get }
    var popOverBackgroundColor: UIColor? { get }
    var arrowDirection: UIPopoverArrowDirection { get }
}

extension KUIPopOverUsable {
    
    public var popOverBackgroundColor: UIColor? {
        return nil
    }
    
    public var arrowDirection: UIPopoverArrowDirection {
        return .any
    }
}

public extension UIPopoverArrowDirection {
    static var none: UIPopoverArrowDirection {
        return UIPopoverArrowDirection(rawValue: 0)
    }
}

public typealias ShowPopoverCompletion = () -> Void

public typealias DismissPopoverCompletion = () -> Void

fileprivate class KUIPopOverUsableDismissHandlerWrapper {
    typealias DismissHandler = ((Bool, DismissPopoverCompletion?) -> Void)
    var closure: DismissHandler?
    
    init(_ closure: DismissHandler?) {
        self.closure = closure
    }
}

fileprivate extension UIView {
    
    struct AssociatedKeys {
        static var onDismissHandler = "onDismissHandler"
    }
    
    var onDismissHandler: KUIPopOverUsableDismissHandlerWrapper.DismissHandler? {
        get { return (objc_getAssociatedObject(self, &AssociatedKeys.onDismissHandler) as? KUIPopOverUsableDismissHandlerWrapper)?.closure }
        set { objc_setAssociatedObject(self, &AssociatedKeys.onDismissHandler, KUIPopOverUsableDismissHandlerWrapper(newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
}

extension KUIPopOverUsable where Self: UIView {
    
    public var contentView: UIView {
        return self
    }
    
    public var contentSize: CGSize {
        return frame.size
    }
    
    public func showPopover(sourceView: UIView, sourceRect: CGRect? = nil, shouldDismissOnTap: Bool = true, completion: ShowPopoverCompletion? = nil) {
        let usableViewController = KUIPopOverUsableViewController(popOverUsable: self)
        usableViewController.showPopover(sourceView: sourceView,
                                         sourceRect: sourceRect,
                                         shouldDismissOnTap: shouldDismissOnTap,
                                         completion: completion)
        onDismissHandler = { [weak self] (animated, completion) in
            self?.dismiss(usableViewController: usableViewController, animated: animated, completion: completion)
        }
    }
    
    public func showPopover(barButtonItem: UIBarButtonItem, shouldDismissOnTap: Bool = true, completion: ShowPopoverCompletion? = nil) {
        let usableViewController = KUIPopOverUsableViewController(popOverUsable: self)
        usableViewController.showPopover(barButtonItem: barButtonItem,
                                         shouldDismissOnTap: shouldDismissOnTap,
                                         completion: completion)
        onDismissHandler = { [weak self] (animated, completion) in
            self?.dismiss(usableViewController: usableViewController, animated: animated, completion: completion)
        }
    }
    
    public func dismissPopover(animated: Bool, completion: DismissPopoverCompletion? = nil) {
        onDismissHandler?(animated, completion)
    }
    
    
    // MARK: - Private
    private func dismiss(usableViewController: KUIPopOverUsableViewController, animated: Bool, completion: DismissPopoverCompletion? = nil) {
        if let completion = completion {
            usableViewController.dismiss(animated: animated, completion: { [weak self] in
                self?.onDismissHandler = nil
                completion()
            })
        } else {
            usableViewController.dismiss(animated: animated, completion: nil)
            onDismissHandler = nil
        }
    }
}

extension KUIPopOverUsable where Self: UIViewController {
    
    public var contentView: UIView {
        return view
    }
    
    private var rootViewController: UIViewController? {
//
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.topPresentedViewController
//        return UIApplication.shared.keyWindow?.rootViewController?.topPresentedViewController
    }
    
    private var popOverUsableNavigationController: KUIPopOverUsableNavigationController {
        let naviController = KUIPopOverUsableNavigationController(rootViewController: self)
        naviController.modalPresentationStyle = .popover
        naviController.popoverPresentationController?.delegate = KUIPopOverDelegation.shared
        naviController.popoverPresentationController?.backgroundColor = popOverBackgroundColor
        naviController.popoverPresentationController?.permittedArrowDirections = arrowDirection
        return naviController
    }
    
    private func setup() {
        modalPresentationStyle = .popover
        preferredContentSize = contentSize
        popoverPresentationController?.delegate = KUIPopOverDelegation.shared
        popoverPresentationController?.backgroundColor = popOverBackgroundColor
        popoverPresentationController?.permittedArrowDirections = arrowDirection
    }
    
    public func setupPopover(sourceView: UIView, sourceRect: CGRect? = nil) {
        setup()
        popoverPresentationController?.sourceView = sourceView
        popoverPresentationController?.sourceRect = sourceRect ?? sourceView.bounds
    }
    
    public func setupPopover(barButtonItem: UIBarButtonItem) {
        setup()
        popoverPresentationController?.barButtonItem = barButtonItem
    }
    
    public func showPopover(sourceView: UIView, sourceRect: CGRect? = nil, shouldDismissOnTap: Bool = true, completion: ShowPopoverCompletion? = nil) {
        setupPopover(sourceView: sourceView, sourceRect: sourceRect)
        KUIPopOverDelegation.shared.shouldDismissOnOutsideTap = shouldDismissOnTap
        rootViewController?.present(self, animated: true, completion: completion)
    }
    
    public func showPopoverWithNavigationController(sourceView: UIView, sourceRect: CGRect? = nil, shouldDismissOnTap: Bool = true, completion: ShowPopoverCompletion? = nil) {
        let naviController = popOverUsableNavigationController
        naviController.popoverPresentationController?.sourceView = sourceView
        naviController.popoverPresentationController?.sourceRect = sourceRect ?? sourceView.bounds
        KUIPopOverDelegation.shared.shouldDismissOnOutsideTap = shouldDismissOnTap
        rootViewController?.present(naviController, animated: true, completion: completion)
    }
    
    public func showPopover(barButtonItem: UIBarButtonItem, shouldDismissOnTap: Bool = true, completion: ShowPopoverCompletion? = nil) {
        setupPopover(barButtonItem: barButtonItem)
        KUIPopOverDelegation.shared.shouldDismissOnOutsideTap = shouldDismissOnTap
        rootViewController?.present(self, animated: true, completion: completion)
    }
    
    public func showPopoverWithNavigationController(barButtonItem: UIBarButtonItem, shouldDismissOnTap: Bool = true, completion: ShowPopoverCompletion? = nil) {
        let naviController = popOverUsableNavigationController
        naviController.popoverPresentationController?.barButtonItem = barButtonItem
        KUIPopOverDelegation.shared.shouldDismissOnOutsideTap = shouldDismissOnTap
        rootViewController?.present(naviController, animated: true, completion: completion)
    }
    
    public func dismissPopover(animated: Bool, completion: DismissPopoverCompletion? = nil) {
        dismiss(animated: animated, completion: completion)
    }
}

private final class KUIPopOverUsableNavigationController: UINavigationController {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let popOverUsable = visibleViewController as? KUIPopOverUsable {
            preferredContentSize = popOverUsable.contentSize
        } else {
            preferredContentSize = visibleViewController?.preferredContentSize ?? preferredContentSize
        }
    }
    
}

private final class KUIPopOverUsableViewController: UIViewController, KUIPopOverUsable {
    
    var contentSize: CGSize {
        return popOverUsable.contentSize
    }
    
    var contentView: UIView {
        return view
    }
    
    var popOverBackgroundColor: UIColor? {
        return popOverUsable.popOverBackgroundColor
    }
    
    var arrowDirection: UIPopoverArrowDirection {
        return popOverUsable.arrowDirection
    }
    
    private var popOverUsable: KUIPopOverUsable!
    
    convenience init(popOverUsable: KUIPopOverUsable) {
        self.init()
        self.popOverUsable = popOverUsable
        preferredContentSize = popOverUsable.contentSize
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(popOverUsable.contentView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        popOverUsable.contentView.frame = view.bounds
    }
    
}

private final class KUIPopOverDelegation: NSObject, UIPopoverPresentationControllerDelegate {
    
    static let shared = KUIPopOverDelegation()
    var shouldDismissOnOutsideTap: Bool = false
    
    // MARK: - UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return shouldDismissOnOutsideTap
    }
}

private extension UIViewController {
    
    var topPresentedViewController: UIViewController {
        return presentedViewController?.topPresentedViewController ?? self
    }
    
}

// MARK: - KYCircularProgress
@IBDesignable
open class KYCircularProgress: UIView {
    
    /**
     Current progress value. (0.0 - 1.0)
     */
    @IBInspectable open var progress: Double = 0.0 {
        didSet {
            let clipProgress = max( min( progress, 1.0), 0.0 )
            progressView.update(progress: normalize(progress: clipProgress))
            
            progressChanged?(clipProgress, self)
            delegate?.progressChanged(progress: clipProgress, circularProgress: self)
        }
    }
    
    /**
     Main progress line width.
     */
    @IBInspectable open var lineWidth: Double = 8.0 {
        didSet {
            progressView.shapeLayer.lineWidth = CGFloat(lineWidth)
        }
    }
    
    /**
     Progress bar line cap. The cap style used when stroking the path.
     */
    @IBInspectable open var lineCap: String = CAShapeLayerLineCap.butt.rawValue {
        didSet {
            progressView.shapeLayer.lineCap = CAShapeLayerLineCap(rawValue: lineCap)
        }
    }
    
    /**
     Guide progress line width.
     */
    @IBInspectable open var guideLineWidth: Double = 8.0 {
        didSet {
            guideView.shapeLayer.lineWidth = CGFloat(guideLineWidth)
        }
    }
    
    /**
     Progress guide bar color.
     */
    @IBInspectable open var guideColor: UIColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.2) {
        didSet {
            guideLayer.backgroundColor = guideColor.cgColor
        }
    }
    
    /**
     Switch of progress guide view. If you set to `true`, progress guide view is enabled.
     */
    @IBInspectable open var showGuide: Bool = false {
        didSet {
            guideView.isHidden = !showGuide
            guideLayer.backgroundColor = showGuide ? guideColor.cgColor : UIColor.clear.cgColor
        }
    }
    
    /**
     Progress bar path. You can create various type of progress bar.
     */
    open var path: UIBezierPath? {
        didSet {
            progressView.shapeLayer.path = path?.cgPath
            guideView.shapeLayer.path = path?.cgPath
        }
    }
    
    /**
     Progress bar colors. You can set many colors in `colors` property, and it makes gradation color in `colors`.
     */
    open var colors: [UIColor] = [UIColor(rgba: 0x9ACDE7FF), UIColor(rgba: 0xE7A5C9FF)] {
        didSet {
            update(colors: colors)
        }
    }
    
    /**
     Progress start offset. (0.0 - 1.0)
     */
    @IBInspectable open var strokeStart: Double = 0.0 {
        didSet {
            progressView.shapeLayer.strokeStart = CGFloat(max( min(strokeStart, 1.0), 0.0 ))
            guideView.shapeLayer.strokeStart = CGFloat(max( min(strokeStart, 1.0), 0.0 ))
        }
    }
    
    /**
     Progress end offset. (0.0 - 1.0)
     */
    @IBInspectable open var strokeEnd: Double = 1.0 {
        didSet {
            progressView.shapeLayer.strokeEnd = CGFloat(max( min(strokeEnd, 1.0), 0.0 ))
            guideView.shapeLayer.strokeEnd = CGFloat(max( min(strokeEnd, 1.0), 0.0 ))
        }
    }
    
    open var delegate: KYCircularProgressDelegate?
    
    /**
     Typealias of progressChangedClosure.
     */
    public typealias progressChangedHandler = (_ progress: Double, _ circularProgress: KYCircularProgress) -> Void
    
    /**
     This closure is called when set value to `progress` property.
     */
    private var progressChanged: progressChangedHandler?
    
    /**
     Main progress view.
     */
    private lazy var progressView: KYCircularShapeView = {
        let progressView = KYCircularShapeView(frame: self.bounds)
        progressView.shapeLayer.fillColor = UIColor.clear.cgColor
        progressView.shapeLayer.lineWidth = CGFloat(self.lineWidth)
        progressView.shapeLayer.lineCap = CAShapeLayerLineCap(rawValue: self.lineCap)
        progressView.radius = self.radius
        progressView.shapeLayer.path = self.path?.cgPath
        progressView.shapeLayer.strokeColor = self.tintColor.cgColor
        return progressView
    }()
    
    /**
     Gradient mask layer of `progressView`.
     */
    private lazy var progressLayer: CAGradientLayer = {
        let progressLayer = CAGradientLayer(layer: self.layer)
        progressLayer.frame = self.progressView.frame
        progressLayer.startPoint = CGPoint(x: 0, y: 0.5)
        progressLayer.endPoint = CGPoint(x: 1, y: 0.5)
        progressLayer.mask = self.progressView.shapeLayer
        progressLayer.colors = self.colors
        self.layer.addSublayer(progressLayer)
        return progressLayer
    }()
    
    /**
     Guide view of `progressView`.
     */
    private lazy var guideView: KYCircularShapeView = {
        let guideView = KYCircularShapeView(frame: self.bounds)
        guideView.shapeLayer.fillColor = UIColor.clear.cgColor
        guideView.shapeLayer.lineWidth = CGFloat(self.guideLineWidth)
        guideView.radius = self.radius
        self.progressView.radius = self.radius
        guideView.shapeLayer.path = self.progressView.shapeLayer.path
        guideView.shapeLayer.strokeColor = self.tintColor.cgColor
        guideView.update(progress: normalize(progress: 1.0))
        return guideView
    }()
    
    /**
     Mask layer of `progressGuideView`.
     */
    private lazy var guideLayer: CALayer = {
        let guideLayer = CAGradientLayer(layer: self.layer)
        guideLayer.frame = self.guideView.frame
        guideLayer.mask = self.guideView.shapeLayer
        guideLayer.backgroundColor = self.guideColor.cgColor
        guideLayer.zPosition = -1
        self.layer.addSublayer(guideLayer)
        return guideLayer
    }()
    
    private var radius: Double {
        return lineWidth >= guideLineWidth ? lineWidth : guideLineWidth
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setNeedsLayout()
        layoutIfNeeded()
        
        update(colors: colors)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    /**
     Create `KYCircularProgress` with progress guide.
     
     - parameter frame: `KYCircularProgress` frame.
     - parameter showProgressGuide: If you set to `true`, progress guide view is enabled.
     */
    public init(frame: CGRect, showGuide: Bool) {
        super.init(frame: frame)
        self.showGuide = showGuide
        guideLayer.backgroundColor = showGuide ? guideColor.cgColor : UIColor.clear.cgColor
    }
    
    /**
     This closure is called when set value to `progress` property.
     
     - parameter completion: progress changed closure.
     */
    open func progressChanged(completion: @escaping progressChangedHandler) {
        progressChanged = completion
    }
    
    public func set(progress: Double, duration: Double) {
        let clipProgress = max( min(progress, 1.0), 0.0 )
        progressView.update(progress: normalize(progress: clipProgress), duration: duration)
        
        progressChanged?(clipProgress, self)
        delegate?.progressChanged(progress: clipProgress, circularProgress: self)
    }
    
    private func update(colors: [UIColor]) {
        progressLayer.colors = colors.map {$0.cgColor}
        if colors.count == 1 {
            progressLayer.colors?.append(colors.first!.cgColor)
        }
    }
    
    private func normalize(progress: Double) -> CGFloat {
        return CGFloat(strokeStart + progress * (strokeEnd - strokeStart))
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        let lineHalf = CGFloat(lineWidth / 2)
        progressView.scale = (x: (bounds.width - lineHalf) / progressView.frame.width, y: (bounds.height - lineHalf) / progressView.frame.height)
        progressView.frame = CGRect(x: bounds.origin.x + lineHalf, y: bounds.origin.y + lineHalf, width: bounds.width - lineHalf, height: bounds.height - lineHalf)
        progressLayer.frame = bounds
        guideView.scale = progressView.scale
        guideView.frame = progressView.frame
        guideLayer.frame = bounds
    }
}

public protocol KYCircularProgressDelegate {
    func progressChanged(progress: Double, circularProgress: KYCircularProgress)
}

// MARK: - KYCircularShapeView
class KYCircularShapeView: UIView {
    var radius = 0.0
    var scale: (x: CGFloat, y: CGFloat) = (1.0, 1.0)
    
    override class var layerClass : AnyClass {
        return CAShapeLayer.self
    }
    
    var shapeLayer: CAShapeLayer {
        return layer as! CAShapeLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        update(progress: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shapeLayer.path = shapeLayer.path ?? layoutPath().cgPath
        var affineScale = CGAffineTransform(scaleX: scale.x, y: scale.y)
        shapeLayer.path = shapeLayer.path?.copy(using: &affineScale)
    }
    
    private func layoutPath() -> UIBezierPath {
        let halfWidth = CGFloat(frame.width / 2.0)
        return UIBezierPath(arcCenter: CGPoint(x: halfWidth, y: halfWidth), radius: (frame.width - CGFloat(radius)) / 2, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
    }
    
    fileprivate func update(progress: CGFloat) {
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        shapeLayer.strokeEnd = progress
        CATransaction.commit()
    }
    
    fileprivate func update(progress: CGFloat, duration: Double) {
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fromValue = shapeLayer.presentation()?.value(forKeyPath: "strokeEnd") as? CGFloat
        animation.toValue = progress
        shapeLayer.add(animation, forKey: "animateStrokeEnd")
        CATransaction.commit()
        shapeLayer.strokeEnd = progress
    }
}

// MARK: - UIColor Extension
extension UIColor {
    convenience public init(rgba: Int64) {
        let red   = CGFloat((rgba & 0xFF000000) >> 24) / 255.0
        let green = CGFloat((rgba & 0x00FF0000) >> 16) / 255.0
        let blue  = CGFloat((rgba & 0x0000FF00) >> 8)  / 255.0
        let alpha = CGFloat( rgba & 0x000000FF)        / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

@IBDesignable
class CircularProgressBar: UIView {
    
    var bgPathTopLevel:UIBezierPath!
    var topLevelShapeLayer:CAShapeLayer!
    var topLevelProgressLayer:CAShapeLayer!
    var bgPathSubLevel:UIBezierPath!
    var subLevelShapeLayer:CAShapeLayer!
    var subLevelProgressLayer:CAShapeLayer!
    var progressText:UILabel!
    
    @IBInspectable var showProgressText:Bool = false
    
    @IBInspectable var innerProgress:CGFloat = 0 {
        willSet(newValue) {
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = innerProgress
            animation.toValue = newValue
            animation.duration = 0
            animation.duration = 1
            subLevelProgressLayer.add(animation, forKey: "drawLineAnimation")
            
        }
    }
    
    @IBInspectable var outerProgress:CGFloat = 0 {
        willSet(newValue) {
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = outerProgress
            animation.toValue = newValue
            animation.duration = 0
            animation.duration = 0.5
            topLevelProgressLayer.add(animation, forKey: "drawLineAnimation")
            
        }
    }
    @IBInspectable var innerThickness:CGFloat = 10.0 {
        willSet(newValue){
            
            subLevelShapeLayer.lineWidth = newValue
            subLevelProgressLayer.lineWidth = newValue
        }
    }
    @IBInspectable var progress:CGFloat = 0.0 {
        willSet (newValue) {
            if showProgressText {
                var preogressStr = ""
                
                if (0 ... 1).contains(newValue){
                    
                    preogressStr = String.init(format: "%d%@", Int(newValue*100),"%")
                }else {
                    preogressStr = String.init(format: "%d%@", 100,"%")
                }
                self.progressText.string = preogressStr
            }
            
            
        }
    }
    @IBInspectable var outerThickness:CGFloat  = 5.0{
        willSet(newValue){
            
            topLevelShapeLayer.lineWidth = newValue
            topLevelProgressLayer.lineWidth = newValue
            
        }
    }
    
    @IBInspectable var outerProgressColor:UIColor = UIColor.blue {
        willSet(newValue){
            
            topLevelProgressLayer.strokeColor = newValue.cgColor
            
        }
    }
    
    @IBInspectable  var innerProgressColor:UIColor = UIColor.clear {
        willSet(newValue) {
            subLevelProgressLayer.strokeColor = newValue.cgColor
        }
    }
    
    @IBInspectable public var thickness:CGFloat = 5
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        simpleShape()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        simpleShape()
    }
    
    override func draw(_ rect: CGRect) {
        self.transform = CGAffineTransform(rotationAngle: CGFloat((Double.pi/2) * -1));
        self.backgroundColor = UIColor.clear
        simpleShape()
    }
    private func createCirclePath() {
        let x = self.bounds.width/2
        let y = self.bounds.height/2
        
        let center = CGPoint(x: x, y: y)
        
        bgPathTopLevel = UIBezierPath.init()
        
        bgPathTopLevel.addArc(withCenter: center, radius: x-10, startAngle: CGFloat(0), endAngle: CGFloat(2*(Double.pi)), clockwise: true)
        
        bgPathSubLevel = UIBezierPath.init()
        bgPathSubLevel.addArc(withCenter: center, radius: x-25, startAngle: CGFloat(0), endAngle: CGFloat(2*(Double.pi)), clockwise: true)
        
        bgPathSubLevel.close()
        
        bgPathTopLevel.close()
        
        if showProgressText {
            progressText = UILabel.init(frame: CGRect.init(x: 0, y: 0, width:(x-25) * 2, height: (x-25) * 2))
            progressText.textColor = UIColor.black
            progressText.string = "0%"
            progressText.textAlignment = .center
            self.addSubview(progressText)
            progressText.backgroundColor = UIColor.clear
            progressText.center = center
            progressText.font = UIFont.systemFont(ofSize:(x-25)/2 )
            progressText.transform = CGAffineTransform(rotationAngle: CGFloat((Double.pi/2)));
        }
        
    }
    
    
    func simpleShape() {
        createCirclePath()
        
        topLevelShapeLayer = CAShapeLayer()
        topLevelShapeLayer.path = bgPathTopLevel.cgPath
        topLevelShapeLayer.lineWidth = outerThickness
        topLevelShapeLayer.fillColor = nil
        topLevelShapeLayer.strokeColor = UIColor.lightGray.cgColor
        
        topLevelProgressLayer = CAShapeLayer()
        topLevelProgressLayer.path = bgPathTopLevel.cgPath
        topLevelProgressLayer.lineWidth = outerThickness
        topLevelProgressLayer.lineCap = CAShapeLayerLineCap.round
        topLevelProgressLayer.fillColor = nil
        topLevelProgressLayer.strokeColor = outerProgressColor.cgColor
        topLevelProgressLayer.strokeEnd = outerProgress
        
        self.layer.addSublayer(topLevelShapeLayer)
        self.layer.addSublayer(topLevelProgressLayer)
        
        subLevelShapeLayer = CAShapeLayer()
        subLevelShapeLayer.path = bgPathSubLevel.cgPath
        subLevelShapeLayer.lineWidth = innerThickness
        subLevelShapeLayer.fillColor = nil
        subLevelShapeLayer.strokeColor = UIColor.lightGray.cgColor
        
        subLevelProgressLayer = CAShapeLayer()
        subLevelProgressLayer.path = bgPathSubLevel.cgPath
        subLevelProgressLayer.lineWidth = innerThickness
        subLevelProgressLayer.lineCap = CAShapeLayerLineCap.round
        subLevelProgressLayer.fillColor = nil
        subLevelProgressLayer.strokeColor = innerProgressColor.cgColor
        subLevelProgressLayer.strokeEnd = innerProgress
        
        self.layer.addSublayer(subLevelShapeLayer)
        
        self.layer.addSublayer(subLevelProgressLayer)
        
        
        
    }
    
}

class HorizontalProgressBar: UIView {
    
    fileprivate var backgroundPath:UIBezierPath!
    fileprivate var backgroundShape:CAShapeLayer!
    
    fileprivate var foregroundPath:UIBezierPath!
    fileprivate var foregroundShape:CAShapeLayer!
    
    fileprivate var textLayer:CATextLayer!
    
    @IBInspectable var barColor:UIColor = UIColor.darkGray
    
    @IBInspectable var progressColor:UIColor = UIColor.red {
        didSet {
            
            if foregroundPath != nil {
                updateStrokeColor()
            }
        }
    }
    
    @IBInspectable var borderColorNewS:UIColor = UIColor.white {
        didSet  {
            
            self.layer.borderColor = self.borderColor?.cgColor ?? UIColor.clear.cgColor
        }
    }
    
    @IBInspectable var showProgressText:Bool = false
    
    @IBInspectable var progressFont:UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    
    
    fileprivate var prevProgress:CGFloat = 0
    
    
    @IBInspectable public var progress:CGFloat = 0 {
        
        willSet{
            
            prevProgress = progress
        }
        didSet {
            
            guard foregroundShape != nil else {
                return
            }
            incrementProgress()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        setup()
        layoutComponents()
        
        self.layer.cornerRadius = 2
        self.layer.borderWidth = 1
        self.layer.borderColor = self.borderColor?.cgColor 
        
    }
    
    fileprivate func incrementProgress() {
        
        foregroundShape.strokeEnd = progress
        
        if progress > 0.1 {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = prevProgress
            animation.toValue = progress
            animation.duration = 0
            animation.duration = 2.5
            foregroundShape.add(animation, forKey: "drawLineAnimation")
        }
        
        if showProgressText {
            self.textLayer.string = String.init(format: "%d %@", Int(progress*100),"%")
        }
    }
    
    fileprivate func layoutComponents() {
        
        backgroundPath = UIBezierPath.init()
        backgroundPath.move(to: CGPoint.init(x: 0, y: 0))
        backgroundPath.addLine(to: CGPoint.init(x: self.bounds.width, y: 0))
        
        
        backgroundShape = CAShapeLayer.init()
        backgroundShape.path = backgroundPath.cgPath
        backgroundShape.strokeColor = self.barColor.cgColor
        backgroundShape.lineWidth = self.bounds.width
        
        
        foregroundPath = UIBezierPath.init()
        foregroundPath.move(to: CGPoint.init(x: 0, y: 0))
        foregroundPath.addLine(to: CGPoint.init(x: self.bounds.width, y: 0))
        
        foregroundShape = CAShapeLayer.init()
        foregroundShape.path = foregroundPath.cgPath
        foregroundShape.strokeColor = self.progressColor.cgColor
        foregroundShape.strokeEnd = 0
        foregroundShape.lineWidth = self.bounds.width
        
        self.layer.addSublayer(backgroundShape)
        self.layer.addSublayer(foregroundShape)
        if showProgressText{
            addTextLayer()
        }
    }
    fileprivate func  updateStrokeColor() {
        
        foregroundShape.strokeColor = self.progressColor.cgColor
        
    }
    
    fileprivate func addTextLayer() {
        
        textLayer  = CATextLayer.init()
        textLayer.frame = CGRect.init(x: 0, y: 0 , width: self.layer.bounds.width, height: self.layer.bounds.height)
        textLayer.alignmentMode = .center
        textLayer.foregroundColor = UIColor.white.cgColor
        self.layer.addSublayer(textLayer)
        textLayer.string = ""
        textLayer.font = progressFont
        textLayer.fontSize = (self.layer.bounds.height * 0.7)
        
        textLayer.shadowColor = UIColor.black.cgColor
        textLayer.shadowOffset = CGSize.init(width: 0.5, height:0.5)
        
        textLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(textLayer)
        self.textLayer.string = String.init(format: "%d %@", Int(progress*100),"%")
    }
    
    fileprivate func setup(){
        self.clipsToBounds = true
    }
    
    
    
    
}
