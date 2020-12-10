//
//  UIViewController+Extension.swift
//  iKioska
//
//  Created by Jassie on 28/09/2017.
//  Copyright © 2017 Jassie. All rights reserved.
//

import Foundation
import UIKit



@IBDesignable
class GradientTopBottomViewWithThreeLayer: UIView {
    let gradientLayer = CAGradientLayer()
    
    @IBInspectable
    var topGradientColor: UIColor = UIColor.clear {
        didSet {
            updateView()//setGradient(leftGradientColor: leftGradientColor, rightGradientColor: rightGradientColor)
        }
    }
    @IBInspectable
    var betweenGradientColor: UIColor = UIColor.clear {
        didSet {
            updateView()//setGradient(leftGradientColor: leftGradientColor, rightGradientColor: rightGradientColor)
        }
    }
    
    @IBInspectable
    var bottomGradientColor: UIColor = UIColor.clear {
        didSet {
            updateView()
            //setGradient(leftGradientColor: leftGradientColor, rightGradientColor: rightGradientColor)
        }
    }
    
    override class var layerClass: AnyClass{
        get{
            return CAGradientLayer.self
        }
    }
    
    private func updateView(){
        let layer = self.layer as! CAGradientLayer
        layer.colors = [topGradientColor.cgColor, betweenGradientColor.cgColor,bottomGradientColor.cgColor]
        layer.locations = [0.0,0.5,1.0]
    }

}

@IBDesignable
class GradientTopBottomView: UIView {
    let gradientLayer = CAGradientLayer()
    
    @IBInspectable
    var topGradientColor: UIColor = UIColor.clear {
        didSet {
            updateView()//setGradient(leftGradientColor: leftGradientColor, rightGradientColor: rightGradientColor)
        }
    }
    
    @IBInspectable
    var bottomGradientColor: UIColor = UIColor.clear {
        didSet {
            updateView()
            //setGradient(leftGradientColor: leftGradientColor, rightGradientColor: rightGradientColor)
        }
    }
    
    override class var layerClass: AnyClass{
        get{
            return CAGradientLayer.self
        }
    }
    
    private func updateView(){
        let layer = self.layer as! CAGradientLayer
        layer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
//        layer.startPoint = CGPoint(x: 0, y: 0)
//        layer.endPoint = CGPoint(x: 0, y: 0.5)
        layer.locations = [0.5]
    }
    
    
}

@IBDesignable
class GradientLeftRightView: UIView {
    let gradientLayer = CAGradientLayer()
    
    @IBInspectable
    var leftGradientColor: UIColor = UIColor.clear {
        didSet {
            updateView()//setGradient(leftGradientColor: leftGradientColor, rightGradientColor: rightGradientColor)
        }
    }
    
    @IBInspectable
    var rightGradientColor: UIColor = UIColor.clear {
        didSet {
            updateView()
            //setGradient(leftGradientColor: leftGradientColor, rightGradientColor: rightGradientColor)
        }
    }
    
    override class var layerClass: AnyClass{
        get{
            return CAGradientLayer.self
        }
    }
    
    private func updateView(){
        let layer = self.layer as! CAGradientLayer
        layer.colors = [leftGradientColor.cgColor, rightGradientColor.cgColor]
        layer.startPoint = CGPoint(x: 0, y: 1)
        layer.endPoint = CGPoint(x: 1, y: 1)
//        layer.colors = [topGradientColor.cgColor, betweenGradientColor.cgColor,bottomGradientColor.cgColor]
        layer.locations = [0.1,1.0]
//        layer.locations = [0.6]
    }
 
}

class GradientLeftRightViewWithThreeLayer: UIView {
    let gradientLayer = CAGradientLayer()
    
    @IBInspectable
    var betweenGradientColor: UIColor = UIColor.clear {
        didSet {
            updateView()//setGradient(leftGradientColor: leftGradientColor, rightGradientColor: rightGradientColor)
        }
    }
    
    @IBInspectable
    var leftGradientColor: UIColor = UIColor.clear {
        didSet {
            updateView()//setGradient(leftGradientColor: leftGradientColor, rightGradientColor: rightGradientColor)
        }
    }
    
    @IBInspectable
    var rightGradientColor: UIColor = UIColor.clear {
        didSet {
            updateView()
            //setGradient(leftGradientColor: leftGradientColor, rightGradientColor: rightGradientColor)
        }
    }
    
    override class var layerClass: AnyClass{
        get{
            return CAGradientLayer.self
        }
    }
    
    private func updateView(){
        let layer = self.layer as! CAGradientLayer
        layer.colors = [leftGradientColor.cgColor, betweenGradientColor.cgColor,rightGradientColor.cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.locations = [0,0.5,1]
    }
    
    private func setGradient(leftGradientColor: UIColor?, rightGradientColor: UIColor?) {
        if let leftGradientColor = leftGradientColor, let rightGradientColor = rightGradientColor {
            gradientLayer.frame = bounds
            gradientLayer.colors = [leftGradientColor.cgColor, rightGradientColor.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = layer.cornerRadius
            layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
}
