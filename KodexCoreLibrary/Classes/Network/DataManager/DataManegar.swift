//
//  DataManegar.swift
//  Trecco
//
//  Created by Jassie on 11/11/19.
//  Copyright © 2019 Jhony. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

open class DataManager: NSObject {
    open var token:String? {
        set(value) {
            if(value != nil){
                UserDefaults.standard.set(value, forKey: "Token")
            }
        }
        get {
            let stToken = UserDefaults.standard.string(forKey: "Token")
            if(stToken == nil){
                return nil
            }else if (stToken?.isEmpty ?? false) {
                return nil
            }else{
                return stToken
            }
        }
    }
    open func saveUserPermanentally<T: Codable>(_ item:T?) {
        UserDefaults.standard.setCodableObject(item, forKey: kUserPrefKey)
    }
    
    open func getPermanentlySavedUser<T: Codable>() -> T? {
        if let data = UserDefaults.standard.codableObject(dataType: T.self, key: kUserPrefKey) {
            return data
        } else {
            return nil
        }
    }
    
    open func getScreenWidth() -> CGFloat {
        return CGFloat.init(UserDefaults.standard.double(forKey: "ScreenWidth"))
    }
    
    open func setScreenWidth(value:CGFloat) {
        UserDefaults.standard.set(Double.init(value), forKey: "ScreenWidth")
    }
    
    open func getScreenHeight() -> CGFloat {
        return CGFloat.init(UserDefaults.standard.double(forKey: "ScreenHeight"))
    }
    open func setScreenHeight(value:CGFloat) {
        UserDefaults.standard.set(Double.init(value), forKey: "ScreenHeight")
    }
    var deviceToken:String = UIDevice.current.identifierForVendor!.uuidString
    
    public static let sharedInstance = DataManager()
    
    func logoutUser() {
        self.resetDefaults()
        UserDefaults.standard.removeObject(forKey: "user")
    }
    
    public var listItems :[String]?
    {
        get {
            UserDefaults.standard.codableObject(dataType: [String].self, key: "Listit")
        }
        set {
            UserDefaults.standard.setCodableObject(newValue, forKey: "Listit")
        }
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}


extension UserDefaults {
  func codableObject<T : Codable>(dataType: T.Type, key: String) -> T? {
    guard let userDefaultData = data(forKey: key) else {
      return nil
    }
    return try? JSONDecoder().decode(T.self, from: userDefaultData)
  }
    func setCodableObject<T: Codable>(_ data: T?, forKey defaultName: String) {
      let encoded = try? JSONEncoder().encode(data)
      set(encoded, forKey: defaultName)
    }
}
