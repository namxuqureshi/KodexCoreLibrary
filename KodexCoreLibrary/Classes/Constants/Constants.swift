//
//  Constants.swift
//  Trecco
//
//  Created by Jassie on 05/11/2019.
//  Copyright © 2019 
//

import Foundation
import SystemConfiguration
import Alamofire
import SkeletonView
var kDefualtHeight:CGFloat = CGFloat(48)
var kUserPlaceHolder = UIImage.init(named: "icUserPlaceholder")!
var kBikerPlaceHolder = UIImage.init(named: "icBikerPlaceholder")!
let kServerError                    = "Server Error"
let kPlaceholderDoc = UIImage.init(named: "icPlaceholderDoc")!
let kPlaceholderImage = UIImage.init(named: "tempImage")!
let kPassCheck = "Password must be at-least 6 charactor\nmust contain at-least one Uppercase letter\nmust contain at-least one special letter\nmust contain at-least one number letter"
let layerIdentifierTest             = "test-country-layeer-v2"
let mapBoxStyleUrl                  = "mapbox://styles/jaidee/ckb65fopk3fr81ip6q16ts4cw"//"mapbox://styles/jaidee/ck7bjujw300zh1io3nj2x9usv"
let mapBoxValue                     = "mapbox://jaidee.4fgr54kk"//"mapbox://jaidee.aqmqmk4i"
let countryKeyLayer                 = "countires_lists-2dqfi9"//"ne_10m_admin_0_countries_3-2fnz85"
let kResponseTimeFormat             = "yyyy-MM-dd HH:mm:ss"
let kResponseTimeFormatOnlyDate             = "yyyy-MM-dd"
let kShareMsg                       = ""//https://apps.apple.com/us/app/
let kUnSplashAccessKey              = "chn7anILXfzYcb32-raObDGJVQIG-L4jTs-NixqWWWQ"
let kUnSplashSecertKey              = "rNG-x0ZJMPy1I1mXH4HchGpc28BPb5n6DOxQeSt0tLM"
let kLocality                       = "locality"// for city
let kCellCountryIdentifier          = "kCellCountryIdentifier"
let kAdministrativeAreaLevel3       = "administrative_area_level_3"
let kAdministrativeAreaLevel1       = "administrative_area_level_1"// MARK: For city too if locality not exist
let kAdministrativeAreaLevel2       = "administrative_area_level_2"// MARK: For State
let kCountry                        = "country"// MARK: For Country if not exist then kAdministrativeAreaLevel1
let kPolitical                      = "political"
let kPostalCode                     = "postal_code"// MARK: For Postal Code
let kOneSignalId                    = "9fe158b3-4081-43ef-81ab-fc2dcf11acf7"//"7ef8d89b-ff3a-4440-a562-68c92c8baaea"
let kPoolId                         = "us-east-2:11e74b7e-66cb-40b9-8fc2-50ff74b773c7"//"us-east-2:c90fdf18-4170-4202-a5a9-6691c2c8d6a6"
let kBucketName                     = "cleaques"//"colleaguesdev"//"trecco-userfiles-mobilehub-2086078579"
let GOOGLE_CLIENT_ID                = "500303726624-732kvobp0t4p0qifi1kcs151r5iu6lfv.apps.googleusercontent.com"
let placesKey                       = "AIzaSyC9uE7X-m_BmyHUecALoLERA6f4rQAPrZk"//"AIzaSyBfRJPn3O6lg2WY4iC1CvWA73S9dDAeW1g"
let kIntroImagesArray               = ["tutorial_img","toturial_2", "toturial_3", "toturial_4","toturial_5"]
let kIntroCollectionCell            = "IntroCollectionCell"
let kAdventureCell                  = "AdventureCell"
let kCategoryCollectionCell         = "CategoryCollectionCell"
let kMapItemListCell                = "MapItemListCell"
let kTripTypeListTableViewCell      = "TripTypeListTableViewCell"
let kNearByCollectionViewCell       = "NearByCollectionViewCell"
let kTypesArr                       = ["MAPS","LISTS","TRIPS","PEOPLE"]
let KMyProfileTypes                 = ["LISTS","TRIPS"]
let KProfileFollowers               = ["FOLLOWING","FOLLOWERS"]
let KMySavedFilter                  = ["RECOMMENDATION","LISTS","TRIPS"]//"Place",
let KSettingList                    = ["Profile Settings","Notification Settings" , "Invite Friends" , "Log Out"]
let kMapTypesArr                    = ["Eat","Drink","Stay","Do"]
let kMapTypesIconsArr               = ["ic_eat","ic_drink","ic_bed","ic_bike"]
let kFilterViewWidth                = 228
let kFilteViewHeight                = 275
let kMarkerDetailsHeight            = 300.0
let kFilterViewTag                  = 333
let kTempButtonTag                  = 555
let kUserPrefKey                    = "user"
let kLimitPage                      = 50
let kLimitPageChat                      = 100
let kLimitPageHome                      = 15
var kLimitRecoPage                  = 1850//14//
var listMapSlection:[MultipleSelectionType] = [MultipleSelectionType]()
var LIMIT_PAGE
    = 10
func kIntroScreenArray() ->[IntroScreenModel]{
    var list = [IntroScreenModel]()
    for index in 0..<5{
        var item = IntroScreenModel()
        switch index {
        case 0:
            item.title = ""//"Scan".uppercased()
            item.subTitle = "Know the world like it’s your hometown".uppercased()
            item.description = "A global travel community built on trust"
            break
        case 1:
            item.title = "CONNECT".uppercased()
            item.subTitle = "Build Your Community".uppercased()
            item.description = "Find and follow your friends, friends of friends, and travel experts all on one platform"
            break
        case 2:
            item.title = "Discover".uppercased()
            item.subTitle = "the latest trends".uppercased()
            item.description = "Recommendations shared from the people you trust and travel experts you choose to follow"
            break
        case 3:
            item.title = "Save & Plan".uppercased()
            item.subTitle = "Your next adventure".uppercased()
            item.description = "Easily create a list for your next solo trip or collaborate with friends on an itinerary"
            break
        case 4:
            item.title = "Share".uppercased()
            item.subTitle = "Your recommendations".uppercased()
            item.description = "Seamlessly share your favorite restaurants, bars, hotels and activities. Say goodbye to the days of shared docs."
            break
        default: break
            
        }
        list.append(item)
    }
    return list
}

class MultipleSelectionType:NSObject {
    var name:String = ""
    var isSelection:Bool = false
    init(nameType:String,selection:Bool) {
        self.name = nameType
        self.isSelection = selection
    }
}

func setupSelectionArray(){
    listMapSlection.removeAll()
    for item in kMapTypesArr {
        listMapSlection.append(MultipleSelectionType.init(nameType: item, selection: false))
    }
}

public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}

struct FontFamilyName {
   
    static let kOSBold = "SFProText-Bold"
    static let kOSBoldItalic = "SFProText-BoldItalic"
    static let kOSSemiBold = "SFProText-SemiBold"
    static let kOSSemiBoldItalic = "SFProText-SemiBoldItalic"
    static let kOSExtraBold = "SFProText-Heavy"
    static let kOSExtraBoldItalic = "SFProText-HeavyItalic"
    static let kOSItalic = "SFProtext-MediumItalic"
    static let kOSLight = "SFProtext-Light"
    static let kOSLightItalic = "SFProtext-LightItalic"
    static let kOSRegular = "SFProtext-Regular"
    static let kOSMedium = "SFProtext-Medium"
    static let KPopinBold = "Poppins-Bold"
    static let KPopinRegular = "Poppins-Regular"
    static let KPopinLight = "Poppins-Medium"
    
}

enum ProjectFont {
    
    case kOSBold(CGFloat)
    case PopinsBold(CGFloat)
    case PopinsNormal(CGFloat)
    case PopinsRegular(CGFloat)
    case kOSBoldItalic(CGFloat)
    case kOSSemiBold(CGFloat)
    case kOSSemiBoldItalic(CGFloat)
    case kOSExtraBold(CGFloat)
    case kOSExtraBoldItalic(CGFloat)
    case kOSItalic(CGFloat)
    case kOSLight(CGFloat)
    case kOSLightItalic(CGFloat)
    case kOSRegular(CGFloat)
    
    func font() -> UIFont {
        switch self {
        case .PopinsBold(let size):
            return UIFont(name: FontFamilyName.KPopinBold, size: size)!
        case .PopinsNormal(let size):
            return UIFont(name: FontFamilyName.KPopinRegular, size: size)!
        case .PopinsRegular(let size):
            return UIFont(name: FontFamilyName.KPopinRegular, size: size)!
        case .kOSBold(let size):
            return UIFont(name: FontFamilyName.kOSBold, size: size)!
        case .kOSBoldItalic(let size):
        return UIFont(name: FontFamilyName.kOSBoldItalic, size: size)!
        case .kOSSemiBold(let size):
        return UIFont(name: FontFamilyName.kOSSemiBold, size: size)!
        case .kOSSemiBoldItalic(let size):
        return UIFont(name: FontFamilyName.kOSSemiBoldItalic, size: size)!
        case .kOSExtraBold(let size):
        return UIFont(name: FontFamilyName.kOSExtraBold, size: size)!
        case .kOSExtraBoldItalic(let size):
        return UIFont(name: FontFamilyName.kOSExtraBoldItalic, size: size)!
        case .kOSItalic(let size):
        return UIFont(name: FontFamilyName.kOSItalic, size: size)!
        case .kOSLight(let size):
        return UIFont(name: FontFamilyName.kOSLight, size: size)!
        case .kOSLightItalic(let size):
        return UIFont(name: FontFamilyName.kOSLightItalic, size: size)!
        case .kOSRegular(let size):
        return UIFont(name: FontFamilyName.kOSRegular, size: size)!
        }
    }
    
}

public struct ProjectColor{
    
    static let barTextIconDefaultColor = UIColor.init(named: "BottomBarDefault") ?? UIColor.lightGray
    static let barTextIconSelectedColor = UIColor.init(named: "BottomBarSelected") ?? UIColor.black
    static let redOrangeColor = UIColor.init(hexColor: "E9634B")
    static let pageControlColor = UIColor.init(hexColor: "464646")
    static let groupHeaderBG = UIColor.init(hexColor: "2A2B2A")
    static let secondPlaceColor = UIColor.init(hexColor: "939392")
    static let thirdPlaceColor = UIColor.init(hexColor: "DCA88D")
    static let dimPurple = UIColor.init(hexColor : "717283")
    static let vipGoldColor = UIColor.init(hexColor: "F5B636")
    static let placeHolderTf = UIColor.init(hexColor: "C7C7CD")
    static let redColor = UIColor.init(hexColor: "E1261F")//EE2157
    static let redDarker = UIColor.init(hexColor: "9E0600")
    static let gradientLeftColor = UIColor.init(hexColor: "3AE5A5")
    static let pinColor = UIColor.init(hexColor: "78F9F1")
    static let gradientRightColor = UIColor.init(hexColor: "1CDAE9")
    static let unselectColorTripList = UIColor.init(hexColor: "D8D8D8")
    static let searchTagUnSelectColorNew = UIColor.init(hexColor: "EEEFF2")
    static let yellowColor = UIColor.init(hexColor: "FFDD1B")
    static let purpleColor = UIColor.init(hexColor: "3F1551")
    static let greenColor = UIColor.init(hexColor: "1D8B02")//"8CC63F"
    static let purpleDarkColor = UIColor.init(hexColor: "1C0E44")
    static let segmentUnSelectColor = UIColor.init(hexColor: "BEBEBE")
    static let offSwtichThumbColor = UIColor.init(hexColor: "DFDFDF")
    static let grayKindColor = UIColor.init(hexColor: "959595")
    static let blackKindColor = UIColor.init(hexColor: "313131")
    static let white = UIColor.white
    static let black = UIColor.black
    static let frozyKindColor = UIColor.init(hexColor: "02BDC4")
    static let nonSelectColorContentBy = UIColor.init(hexColor: "B5B8BB")
    static let selectColorContentBy = UIColor.init(hexColor: "2f2f2f")//24375C
    static let treccoBlue = UIColor.init(hexColor: "2F2F2F")//old color "24375C"
    static let homeSubTitleColor = UIColor.init(hexColor: "939393")
    static let treccoBlueOld = UIColor.init(hexColor: "2F2F2F")//UIColor.init(hexColor: "24375C")//old color "24375C"
    static let messageArrowCountZeroColor = UIColor.init(hexColor: "D1D8E7")
    static let lineColor = UIColor.init(hexColor: "F3F3F3")//D8D8D8
    static let searchNonSelectColor = UIColor.init(hexColor: "9AABB6")
    // MARK: New Font Color
    static let textColor = UIColor.init(hexColor: "2F2F2F")
    static let calenderSelected = UIColor.init(hexColor: "2f2f2f")//24375C//UIColor.init(hexColor: "01B789")
    static let dateNumberColor = UIColor.init(hexColor: "171F24")
    static let monthColor = UIColor.init(hexColor: "2f2f2f")//24375C
    static let deleteSwipeColor = UIColor.init(hexColor: "FEEBF1")
    static let deletrSwipeTxtColor = UIColor.init(hexColor: "F51E5B")
    static let unreadNotifyColor = UIColor.init(hexColor: "F6F7F9")
    static let eventDetailAllHotelNoteSelection = UIColor.init(hexColor: "4A90E2")
    static let onlyPicterCounterColor = UIColor.init(hexColor: "393939")
    static let protipLikeColor = UIColor.init(hexColor: "F54B64")
    static let protipLikeColorBg = UIColor.init(hexColor: "FEEDEF")
    static let protipEditColorBg = UIColor.init(hexColor: "F4F4F6")
    static let calenderDayWeekColor = UIColor.init(hexColor: "778087")
    static let multiDaysUnSelectColor = UIColor.init(hexColor: "ECECEC")
    static let searchTagUnSelectColor = UIColor.init(hexColor: "D0D4DA")
    static let publicPrivateUnSelectColor = UIColor.init(hexColor: "676767")
    static let proTripAddedInWhichColor = UIColor.init(hexColor: "979797")
    static let culesterStrokeColor = UIColor.init(hexColor: "182A4D")
    static let mapBoxLayerColor = UIColor.init(hexColor: "24375C").withAlphaComponent(0.5)//UIColor.black//UIColor.init(hexColor: "598CD8")
    static let txtMsgColor = UIColor.init(hexColor: "97A1A4")//UIColor.white
    static let chatBgColor = UIColor.init(hexColor: "FBFCFE")
    static let culesterBGColor = UIColor.init(hexColor: "F8E71C")
    static let toastBgColor = UIColor.init(hexColor: "1FB892")
    public static let buttonColor = UIColor.init(hexColor: "262065")
    static let buttonSelectedColor = UIColor.init(hexColor: "999999")
    static let placeholderColor = UIColor.init(hexColor: "999999")
    
    //
}

enum IphoneType {
    case IPHONE_5_5S_5C
    case IPHONE_6_6S_7_8
    case IPHONE_6PLUS_6SPLUS_7PLUS_8PLUS
    case IPHONE_X_XS_11_Pro
    case IPHONE_XS_Max_11_Pro_Max
    case IPHONE_XR_11
    case UNKNOWN
}

func checkIphoneIs() -> IphoneType{
    if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return .IPHONE_5_5S_5C
        case 1334:
            return .IPHONE_6_6S_7_8
        case 1920, 2208:
            return .IPHONE_6PLUS_6SPLUS_7PLUS_8PLUS
        case 2436:
            return .IPHONE_X_XS_11_Pro
        case 2688:
            return .IPHONE_XS_Max_11_Pro_Max
        case 1792:
            return .IPHONE_XR_11
        default:
            return .UNKNOWN
        }
    }else{
        return .UNKNOWN
    }
}

func isPrime(_ number: Int) -> Bool {
    return number > 1 && !(2..<number).contains { number % $0 == 0 }
}

// Animation View For UIVIEW


extension NSLayoutConstraint {
    
    func setMultiplier(_ multiplier:CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint.deactivate([self])
        let newConstraint = NSLayoutConstraint(
            item: firstItem as Any,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = shouldBeArchived
        newConstraint.identifier = identifier
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
    func setRelation(_ relation:NSLayoutConstraint.Relation,_ constant:CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint.deactivate([self])
        let newConstraint = NSLayoutConstraint(
            item: firstItem as Any,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = shouldBeArchived
        newConstraint.identifier = identifier
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}

struct IntroScreenModel {
    var title:String = ""
    var subTitle:String = ""
    var description:String = ""
    
    init(title:String,subTitle:String,description:String) {
        self.title = title
        self.subTitle = subTitle
        self.description = description
    }
    init() {
        
    }
}

extension UIImageView {
    override open func awakeFromNib() {
        super.awakeFromNib()
        tintColorDidChange()
    }
}





public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

extension UIApplication {
    
    static var isRTL: Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == UIUserInterfaceLayoutDirection.rightToLeft
    }
}


extension UIScrollView {
    
    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y,width: 1,height: self.frame.height), animated: animated)
        }
    }
    
    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
}

func genratesDate(lhs:Date, rhs:Date) -> [Date] {
    var dates = [Date]()
    var dayCount = 0
    while true {
        let cal = Calendar.current
        var days = DateComponents()
        days.day = dayCount
        let date = cal.date(byAdding: days, to: lhs)!
        if date.compare(rhs) == .orderedDescending {
            break
        }
        dayCount += 1
        dates.append(date)
    }
    
    return dates
}

extension UIImage {
    func imageWithInsets(insetDimen: CGFloat) -> UIImage? {
        return imageWithInset(insets: UIEdgeInsets(top: insetDimen, left: insetDimen, bottom: insetDimen, right: insetDimen))
    }
    
    func imageWithInset(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at:origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
    
}

extension UITextField {
    class func connectFields(_ fields:[Any?]) -> Void {
        guard let last = fields.last else {
            return
        }
        for i in 0 ..< fields.count - 1 {
            if let item = fields[i] as? UITextField {
                item.returnKeyType = .next
                item.addTarget(fields[i+1] , action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
            }else if let item = fields[i] as? UITextView {
                item.returnKeyType = .next
                item.target(forAction: #selector(UIResponder.becomeFirstResponder), withSender: fields[i+1])
            }
        }
        if let item = last as? UITextField {
            item.returnKeyType = .done
            item.addTarget(item, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
        }
//        else if let item = last as? UITextView {
//            item.returnKeyType = .done
//            item.target(forAction: #selector(UIResponder.resignFirstResponder), withSender: <#T##Any?#>)//addTarget(item, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
//        }
        
    }
}

class NezuitGroteskLabel: UILabel {
    
    let topInset = CGFloat(5.0), bottomInset = CGFloat(0.0), leftInset = CGFloat(0.0), rightInset = CGFloat(0.0)
    
    override func drawText(in rect: CGRect) {
        
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
        
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
    
}

class NezuitGroteskLabelExtra: UILabel {
    
    let topInset = CGFloat(12.0), bottomInset = CGFloat(0.0), leftInset = CGFloat(0.0), rightInset = CGFloat(0.0)
    
    override func drawText(in rect: CGRect) {
        
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
        
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
    
}

class BabusNueueLabel:UILabel{
    let topInset = CGFloat(1.5), bottomInset = CGFloat(0.0), leftInset = CGFloat(0.0), rightInset = CGFloat(0.0)
    
    override func drawText(in rect: CGRect) {
        
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
        
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
}

class NezuitGrotestTF:UITextField {
    let topInset = CGFloat(5.0), bottomInset = CGFloat(0.0), leftInset = CGFloat(0.0), rightInset = CGFloat(0.0)
    
    override func drawText(in rect: CGRect) {
        
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
        
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
}

class NezuitGrotestTV:UITextView{
    let topInset = CGFloat(5.0), bottomInset = CGFloat(0.0), leftInset = CGFloat(-5.0), rightInset = CGFloat(0.0)
    
//    override func draw(_ layer: CALayer, in ctx: CGContext) {
//        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
//        super.draw(rect.inset(by: insets))
//    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        textContainerInset = insets
    }
    
    
    override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
}

extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

}

extension UITextField {
    var string:String? {
        get {
           return self.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        set {
           self.text = newValue?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        }
    }
    var txtColor :UIColor? {
        get {
            return self.textColor
        }
        set {
            self.textColor = newValue
        }
    }
    
}
extension UITextView {
    var string:String? {
        get {
           return self.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        set {
           self.text = newValue?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        }
    }
    var txtColor :UIColor? {
        get {
            return self.textColor
        }
        set {
            self.textColor = newValue
        }
    }
}
extension UILabel {
    var string:String? {
        get {
           return self.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        set {
           self.text = newValue?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        }
    }
    var txtColor :UIColor? {
        get {
            return self.textColor
        }
        set {
            self.textColor = newValue
        }
    }
    
}
extension UIButton {
    
    var image:UIImage? {
        get {
            return self.currentImage
        }
        set {
            self.setImage(newValue, for: .normal)
            self.setImage(newValue, for: .selected)
            self.setImage(newValue, for: .highlighted)
            self.setImage(newValue, for: .disabled)
        }
    }
    
    var txtColor :UIColor? {
        get {
            return self.titleLabel?.textColor
        }
        set {
            self.setTitleColor(newValue, for: .normal)
        }
    }
    var string :String? {
        get {
            return self.titleLabel?.string ?? ""
        }
        set {
            self.setTitle(newValue?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "", for: .normal)
            self.setTitle(newValue?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "", for: .selected)
            self.setTitle(newValue?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "", for: .highlighted)
        }
    }
}



var localUserApp : User? {
    get {
        return DataManager.sharedInstance.getPermanentlySavedUser()
    }
}
//var localUserAppPic : String? {
//    get {
//        return DataManager.sharedInstance.localUserPic()
//    }
//}
//var localUserAppId : Int? {
//    get {
//        return DataManager.sharedInstance.localUserId()
//    }
//}


extension DispatchQueue {

    static func myBackground(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.async {
                    completion()
                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
//
//                })
            }
        }
    }
}


extension UILabel {
    
    var isTruncated: Bool {
        
        guard let labelText = text else {
            return false
        }
        
        let labelTextSize = (labelText as NSString).boundingRect(with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),options: .usesLineFragmentOrigin,attributes: [NSAttributedString.Key.font: font ?? ProjectFont.kOSBold(CGFloat(16)).font()],context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
    
    
    var numberOfLinesVisible : Int {
        
        if let text = text{
            // cast text to NSString so we can use sizeWithAttributes
            let myText = text as NSString
            
            //Set attributes
            let attributes = [NSAttributedString.Key.font : font!]
            
            //Calculate the size of your UILabel by using the systemfont and the paragraph we created before. Edit the font and replace it with yours if you use another
            let labelSize = myText.boundingRect(with: CGSize(width: bounds.width,height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            
            //Now we return the amount of lines using the ceil method
            let lines = ceil(CGFloat(labelSize.height) / font.lineHeight)
            return Int(lines)
        }
        
        return 0
    }
}


extension UIImageView {
    
    func rotate(at angle : Int) {
        if angle == 0 || angle == 360 {
            self.transform = CGAffineTransform(rotationAngle: 0)
        }else if angle == 90 {
            self.transform = CGAffineTransform(rotationAngle: .pi / 2)
        }else if angle == 180 {
            self.transform = CGAffineTransform(rotationAngle: .pi)
        }else if angle == 270 {
            self.transform = CGAffineTransform(rotationAngle: .pi * 1.5)
        }else{
            self.transform = CGAffineTransform(rotationAngle: 0)
        }
    }
    
    func addCircleGradiendBorder(_ width: CGFloat) {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: bounds.size)
        let colors: [CGColor] = [ProjectColor.gradientLeftColor.cgColor,ProjectColor.gradientRightColor.cgColor]
        gradient.colors = colors
        gradient.startPoint = CGPoint(x: 1, y: 0.5)
        gradient.endPoint = CGPoint(x: 0, y: 0.5)
        
        let cornerRadius = frame.size.width / 2
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
//        if(self.borderWidth == 0.0){
//            self.borderWidth = 3
//        }
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: bounds)
        
        shape.lineWidth = 3//width
        shape.path = path.cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor // clear
        gradient.mask = shape
        
        layer.insertSublayer(gradient, below: layer)
    }
    
}

//mask = +(XXX) XXX XXXXXX // can b any one like this
func formatPhoneNumber(with mask: String, phone: String) -> String {
    let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    var result = ""
    var index = numbers.startIndex // numbers iterator
    
    // iterate over the mask characters until the iterator of numbers ends
    for ch in mask where index < numbers.endIndex {
        if ch == "X" {
            // mask requires a number in this place, so take the next one
            result.append(numbers[index])
            
            // move numbers iterator to the next index
            index = numbers.index(after: index)
            
        } else {
            result.append(ch) // just append a mask character
        }
    }
    return result
}

extension String {
    func formatCurrency() -> String{
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        if let number = Double(self),let formattedTipAmount = formatter.string(from: NSNumber.init(value: number)) {
            return "\(formattedTipAmount)"
        }else{
            return ""
        }
    }
}
class CountryData {
    static let sharedInstance = CountryData()
    let languageList = Locale.isoLanguageCodes.compactMap { Locale.current.localizedString(forLanguageCode: $0) }
    let countryList = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
    
}



extension String {
    var link:URL?{
        return URL.init(string: self)
    }
}



func getMapLink(lat: String, lng: String) -> URL? { //&zoom=10
    return URL.init(string: "https://maps.googleapis.com/maps/api/staticmap?autoscale=2&zoom=4.02&size=1600x1400&maptype=roadmap&style=element:geometry%7Ccolor:0x212121&style=element:labels.text.fill%7Ccolor:0x757575&style=element:labels.icon%7Cvisibility:off&style=element:labels.text.stroke%7Ccolor:0x212121&style=feature:administrative%7Celement:geometry%7Ccolor:0x757575&style=feature:administrative.country%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.locality%7Celement:labels.text.fill%7Ccolor:0xbdbdbd&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:poi.park%7Celement:geometry%7Ccolor:0x181818&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x616161&style=feature:poi.park%7Celement:labels.text.stroke%7Ccolor:0x1b1b1b&style=feature:road%7Celement:geometry.fill%7Ccolor:0x2c2c2c&style=feature:road%7Celement:labels.text.fill%7Ccolor:0x8a8a8a&style=feature:road.arterial%7Celement:geometry%7Ccolor:0x373737&style=feature:road.highway%7Celement:geometry%7Ccolor:0x3c3c3c&style=feature:road.highway.controlled_access%7Celement:geometry%7Ccolor:0x4e4e4e&style=feature:road.local%7Celement:labels.text.fill%7Ccolor:0x616161&style=feature:transit%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:water%7Ccolor:0x212121&style=feature:water%7Celement:geometry%7Ccolor:0x000000&style=feature:water%7Celement:geometry.fill%7Ccolor:0x3c4351&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x3d3d3d&key=\(placesKey)&format=gif&visual_refresh=true&markers=size:small%9Ccolor:0xFF2D55%7Clabel:1%7C\(lat),\(lng)")
    }
