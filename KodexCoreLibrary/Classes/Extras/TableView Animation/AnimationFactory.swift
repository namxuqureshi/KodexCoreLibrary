//
//  AnimationFactory.swift
//  Trecco
//
//  Created by Jassie on 11/6/19.
//  Copyright © 2019 
//

//import Foundation
//import UIKit
//typealias Animator = (UITableViewCell, IndexPath, UITableView) -> Void
//final class AnimatorLoaf {
//    private var hasAnimatedAllCells = false
//    private let animation: Animator
//
//    init(animation: @escaping Animator) {
//        self.animation = animation
//    }
//
//    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
//        guard !hasAnimatedAllCells else {
//            return
//        }
//
//        animation(cell, indexPath, tableView)
//    }
//}
//
//enum AnimationFactory {
//
//    static func makeFadeAnimation(duration: TimeInterval, delayFactor: Double) -> AnimatorLoaf {
//        return { cell, indexPath, _ in
//            cell.alpha = 0
//
//            UIView.animate(
//                withDuration: duration,
//                delay: delayFactor * Double(indexPath.row),
//                animations: {
//                    cell.alpha = 1
//            })
//        }
//    }
//    
//    static func makeMoveUpWithBounce(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> AnimatorLoaf {
//        return { cell, indexPath, tableView in
//            cell.transform = CGAffineTransform(translationX: 0, y: rowHeight)
//
//            UIView.animate(
//                withDuration: duration,
//                delay: delayFactor * Double(indexPath.row),
//                usingSpringWithDamping: 0.4,
//                initialSpringVelocity: 0.1,
//                options: [.curveEaseInOut],
//                animations: {
//                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
//            })
//        }
//    }
//}
