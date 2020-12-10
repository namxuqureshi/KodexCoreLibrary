
//
//  ArrayExtension.swift
//  Duet
//
//  Created by user on 17/07/2019.
//  Copyright © 2019 
//

import Foundation

extension Array where Element == String {
    func removeDuplicates() -> [String] {
        var result = [String]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }

        return result
    }
    
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
//
//extension Array where Element == QPhoto {
//    func removeDuplicates() -> [QPhoto] {
//        var result = [QPhoto]()
//        for value in self {
//            if !result.contains(where: { (inerItem) -> Bool in
//                return inerItem.photoRef == value.photoRef
//            }) {
//                result.append(value)
//            }
//        }
//        return result
//    }
//    
//}
//
//
