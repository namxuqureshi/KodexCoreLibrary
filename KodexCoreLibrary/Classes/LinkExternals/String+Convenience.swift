//
//  String+Convenience.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG
import Foundation

extension String {
    func openMessanger(){
        if let url = URL.init(string: "https://m.me/\(self)"){//"https://m.facebook.com/messages/compose?ids=\(self)"
            UIApplication.shared.open(url) { (isOpen) in
                if isOpen {
                    print("LinkOpned")
                }else{
                    print("LinkNotOpned")
                }
            }
        }else
            if let url = URL.init(string: "https://m.me/\(self)"){
                UIApplication.shared.open(url) { (isOpen) in
                    if isOpen {
                        print("LinkOpned")
                    }else{
                        print("LinkNotOpned")
                    }
                }
        }
    }
    
    static func emojiFlag(for countryCode: String) -> String! {
        func isLowercaseASCIIScalar(_ scalar: Unicode.Scalar) -> Bool {
            return scalar.value >= 0x61 && scalar.value <= 0x7A
        }
        
        func regionalIndicatorSymbol(for scalar: Unicode.Scalar) -> Unicode.Scalar {
            precondition(isLowercaseASCIIScalar(scalar))
            
            // 0x1F1E6 marks the start of the Regional Indicator Symbol range and corresponds to 'A'
            // 0x61 marks the start of the lowercase ASCII alphabet: 'a'
            return Unicode.Scalar(scalar.value + (0x1F1E6 - 0x61))!
        }
        
        let lowercasedCode = countryCode.lowercased()
        guard lowercasedCode.count == 2 else { return nil }
        guard lowercasedCode.unicodeScalars.reduce(true, { accum, scalar in accum && isLowercaseASCIIScalar(scalar) }) else { return nil }
        
        let indicatorSymbols = lowercasedCode.unicodeScalars.map({ regionalIndicatorSymbol(for: $0) })
        return String(indicatorSymbols.map({ Character($0) }))
    }
    
    public func RemoveSpace() -> String{
        let newString = self.replacingOccurrences(of: " ", with: "%20")
        return newString
    }
    func replaceSpace(str : String) -> String{
        let newString = self.replacingOccurrences(of: " ", with: str)
        return newString
    }
    
    func stringFromCamelCase() -> String {
        var string = self
        string = string.replacingOccurrences(
            of: "([a-z])([A-Z])",
            with: "$1 $2",
            options: .regularExpression,
            range: nil
        )
        string.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]))
        
        return String(string.prefix(1)).capitalized + String(string.lowercased().dropFirst())
    }
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    func localized(withTableName tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value, comment: self)
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString.init(string: self)
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
}

protocol StringType { var get: String { get } }
extension String: StringType { var get: String { return self } }
extension Optional where Wrapped: StringType {
    func unwrap() -> String {
        return self?.get ?? ""
    }
}

extension String {
    
    func canOpenURL() -> Bool {
        guard let url = URL(string: self) else {return false}
        if !UIApplication.shared.canOpenURL(url) {return false}
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: self)
    }
    
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.trimmingCharacters(in: .whitespaces))
    }
   
    var isPhoneNumber: Bool {
        do {
            let phone = self.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "+", with: "")
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: phone, options: [], range: NSRange(location: 0, length: phone.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == phone.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func isValidPassword() -> Bool {
        //                         "^(?=.*[a-z])(?=.*[A-Z]).{6,}$"
        let emailRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[0-9])(?=.*[A-Z]).{6,}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.trimmingCharacters(in: .whitespaces))
    }
    
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    func boldString(fontSize : CGFloat ,font : UIFont?) -> NSMutableAttributedString {
        let attrs = [NSAttributedString.Key.font : font ?? UIFont.systemFont(ofSize: 8)]
        return NSMutableAttributedString(string:self, attributes:attrs)
    }
    
    static func abbreviateNumber(num: Float) -> String {
        var ret: NSString = ""
        let abbrve: [String] = ["K", "M", "B"]
        let floatNum = num
        if floatNum > 1000 {

            for i in 0..<abbrve.count {
                let size = pow(10.0, (Float(i) + 1.0) * 3.0)
                if (size <= floatNum) {
                    let num = floatNum / size
                    let str = String.floatToString(val: num)
                    ret = NSString(format: "%@%@", str, abbrve[i])
                }
            }
        } else {
            ret = NSString(format: "%d", Int(floatNum))
        }

        return ret.lowercased
    }

    static func floatToString(val: Float) -> String {
        var ret = NSString(format: "%.1f", val)
        var c = ret.character(at: ret.length - 1)
        while c == 48 {
            ret = NSString.init(string: ret.substring(to: ret.length - 1))
            c = ret.character(at: ret.length - 1)
            if (c == 46) {
                ret = NSString.init(string: ret.substring(to: ret.length - 1))
            }
        }
        return ret.lowercased
    }

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func getDateFormatSpecial(inputFormat:String = DateFormatType.isoDateTimeMilliSec.stringFormat,outPutFormat:String = "") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        if(inputFormat == DateFormatType.isoDateTimeMilliSec.stringFormat){//"yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//            dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")//(name: "UTC")
        }
        guard let date = dateFormatter.date(from: self) else {
            assert(false, "no date from string")
            return ""
        }
        
        if(outPutFormat.isEmpty){
            return date.toLocalTime().timeAgoDisplay()
        }
        dateFormatter.dateFormat = outPutFormat
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date)
        return timeStamp
    }
    
    func getDateFormat(inputFormat:String,outPutFormat:String,_ isLocalConvert:Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let dt = isLocalConvert ? dateFormatter.date(from: self)?.toLocalTime() : dateFormatter.date(from: self)
        if dt != nil{
            let formatter = DateFormatter();
            formatter.dateFormat = outPutFormat
            let mnth_name =  formatter.string(from: dt!)
            return mnth_name
        }
        return ""
    }
    
    func getDate(inputFormat:String,_ isNeedLocal:Bool = true) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let dt = isNeedLocal ? dateFormatter.date(from: self)?.toLocalTime() : dateFormatter.date(from: self)
        return  dt ?? Date()
    }
    func getDateAS(inputFormat:String,_ isNeedLocal:Bool = true) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let dt = isNeedLocal ? dateFormatter.date(from: self)?.toLocalTime() : dateFormatter.date(from: self)
        return  dt
    }
    
    
    func getAgeFormDOB() -> String{
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMMM-yyyy"
        let birthday: Date = formatter.date(from: self)!
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
        return String(age)
    }
    
    
    
    
}

extension String {
    
    var parseJSONString: AnyObject? {
        
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)

        if let jsonData = data {
            // Will return an object or nil if JSON decoding fails
            do{
                if let json = try (JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary){
                        return json
                }else{
                let json = try (JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray)
                        return json
                }
                
            }catch{
                print("Error")
            }
            
        } else {
            // Lossless conversion of the string was not possible
            return nil
        }
        
        return nil
}
    
    var parseJSONStringArray: AnyObject? {
        
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        let json:NSArray
        
        if let jsonData = data {
            // Will return an object or nil if JSON decoding fails
            do{
                json  = try  JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)  as! NSArray
                
                return json
            }catch{
                print("Error")
            }
            
        } else {
            // Lossless conversion of the string was not possible
            return nil
        }
        
        return nil
    }
}

extension String{
    func toDate( dateFormat format  : String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return dateFormatter.date(from: self)!
    }
   
    func UTCToLocal(inputFormate : String , outputFormate : String) -> String {
        if self.count > 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  inputFormate  //Input Format kResponseTimeFormat
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            let UTCDate = dateFormatter.date(from: self)
            dateFormatter.dateFormat =  outputFormate // Output Format "MM.dd.yyyy hh:mm a"
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            let UTCToCurrentFormat = dateFormatter.string(from: UTCDate!)
            print(UTCToCurrentFormat)
            return UTCToCurrentFormat
        }else{
            return "Empty Date!"
        }
    }
    func getRanges(of string: String) -> [NSRange] {
        var ranges:[NSRange] = []
        if contains(string) {
            let words = self.components(separatedBy: " ")
            var position:Int = 0
            for word in words {
                if word.lowercased() == string.lowercased() {
                    let startIndex = position
                    let endIndex = word.count
                    let range = NSMakeRange(startIndex, endIndex)
                    ranges.append(range)
                }
                position += (word.count + 1)
            }
        }
        return ranges
    }
    
    func getRemidersRemainingDays() -> String{
        let dateRangeStart = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = kResponseTimeFormat
        let dt = dateFormatter.date(from: self)
//        dt = dt?.toLocalTime()
        let calendar = Calendar.current
        if calendar.isDateInTomorrow(dt!) {
            return "Tomorrow"
        }else if  calendar.isDateInToday(dt!){
             return "Today"
        }else{
            var diffInDays = calendar.dateComponents([.day], from: dateRangeStart, to: dt!).day
            if diffInDays! > 0 {
                diffInDays = (diffInDays!) + 1
            }
            if diffInDays! <= 0{
                return "Today"
            }else{
                return "\(String(describing: diffInDays!)) Days"
            }
        }
    }
    
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    var extractURLs: [URL] {
        var urls : [URL] = []
        var error: NSError?
        do{
            let detector = try NSDataDetector.init(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let text = self
            detector.enumerateMatches(in: text, range: NSMakeRange(0, text.count), using: { (result: NSTextCheckingResult!, flags: NSRegularExpression.MatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                //            println("\(result)")
                //            println("\(result.URL)")
                urls.append(result.url!)
            })
        }catch let error1 as NSError {
            error = error1
            print(error!.description)
        } catch {
            // Catch any other errors
            print(error.localizedDescription)
        }
            
            return urls
        
    }
}

extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
        // Swift 4.1 and below
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
}
