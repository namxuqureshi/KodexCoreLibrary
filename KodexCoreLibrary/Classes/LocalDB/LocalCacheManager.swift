//
//  LocalCacheManager.swift
//  KodexCoreNetwork
//
//  Created by Jawad on 11/25/20.
//

import Foundation

public class LocalCacheManager {
    public static let sharedInstance = LocalCacheManager()
    public func addStringToCache(key : String , value : String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
}
