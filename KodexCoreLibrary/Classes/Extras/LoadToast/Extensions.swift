//
//  Extensions.swift
//  EatLove
//
//  Created by Namxu Ihseruq on 11/09/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import YPImagePicker
import Toast_Swift
import Foundation
import AVKit
import SafariServices
import MaterialComponents.MaterialBottomSheet
import ESTabBarController_swift
import MobileCoreServices
import ContactsUI
import LocationPickerViewController

extension UIViewController :SFSafariViewControllerDelegate{
    
    func openBrowser(link:String){
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = false
        config.barCollapsingEnabled = true
        if let url = URL(string: link){
            let vc = SFSafariViewController(url: url, configuration: config)
            vc.dismissButtonStyle = .close
            vc.delegate = self
            self.present(vc, animated: true)
        }
    }
    
    @objc public func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        
    }
    
    class func controllerFromSB()->UIViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: String(describing: self))
    }
    
    
    
    func hideNavigationBar(){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func showNavigationBar() {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    open func pushView(_ vc:UIViewController?,_ isAnimated:Bool = true,isFromTabControllerPush:Bool = false){
        if let vc = vc {
            if(isFromTabControllerPush){
                self.tabBarController?.navigationController?.pushViewController(vc, animated: isAnimated)
            }else{
                self.navigationController?.pushViewController(vc, animated: isAnimated)
            }
        }
    }
    
    open func presentVC(_ vc:UIViewController?,_ isAnimated:Bool = true,isFromTabControllerPush:Bool = false){
        if let vc = vc {
            if(isFromTabControllerPush){
                self.tabBarController?.navigationController?.present(vc, animated: isAnimated, completion: nil)
            }else{
                self.navigationController?.present(vc, animated: isAnimated, completion: nil)
            }
        }
    }
    
    open func presentAlertVC(_ vc:UIViewController?,_ isAnimated:Bool = true,isFromTabControllerPush:Bool = false){
        if let vc = vc {
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            if(isFromTabControllerPush){
                self.tabBarController?.navigationController?.present(vc, animated: isAnimated, completion: nil)
            }else{
                self.navigationController?.present(vc, animated: isAnimated, completion: nil)
            }
        }
    }
    
    func getCountryList() -> [(name: String, flag: String,isoCode:String,isSelected:Bool)]{
        var countriesData = [(name: String, flag: String,isoCode:String,isSelected:Bool)]()
        
        for code in NSLocale.isoCountryCodes  {
            
            let flag = String.emojiFlag(for: code)
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            if let name = NSLocale(localeIdentifier: Locale.autoupdatingCurrent.identifier).displayName(forKey: NSLocale.Key.identifier, value: id) {
                print("CodeIso : \(code) \(name)")
                countriesData.append((name: name, flag: flag!,code,isSelected: false))
            }else{
            }
        }
        return countriesData.sorted { (arg0, arg1) -> Bool in
            switch arg0.name.compare(arg1.name) {
            case .orderedAscending:
                return true
            case .orderedSame:
                return false
            case .orderedDescending:
                return false
            }
        }
    }

    var window : UIWindow {
        return UIApplication.shared.windows.first!
    }
    
    
    func showToast(text:String,type:Loaf.State,location:Loaf.Location,_ duration:Loaf.Duration = .average,_ completation: (() -> ())? = nil){
        
        switch type {
            
        case .success:
            self.showToastWithImage(text: text, isError: false,location:location)
            completation?()
            break
        case .error:
            self.showToastWithImage(text: text, image: nil, isError: true,location:location)
            completation?()
            break
        case .warning:
            self.showToastWithImage(text: text, image: nil, isError: true,location:location)
            completation?()
            break
        case .info:
            self.showToastWithImage(text: text, image: nil, isError: true,location:location)
            completation?()
            break
        case .custom(_):
            completation?()
            break
            
        }
        
    }
    
    func showToastWithImage(text:String,image:UIImage? = UIImage.init(named: "RecAddIcon"),isError:Bool = false,location:Loaf.Location = .top) {
        var style = ToastStyle()
        if(isError){
            style.backgroundColor = ProjectColor.redColor.withAlphaComponent(0.8)
            style.displayShadow = true
            style.imageSize = CGSize.init(width: 20, height: 20)
            self.window.makeToast(text, duration: 2.0, position: location == .top ? .top : .bottom, title: nil, image: nil,style:style)
        }else{
            style.backgroundColor = ProjectColor.toastBgColor.withAlphaComponent(0.8)
            style.displayShadow = true
            style.imageSize = CGSize.init(width: 20, height: 20)
            
            self.window.makeToast(text, duration: 2.0, position: location == .top ? .top : .bottom, title: nil, image: image,style:style)
        }
        
        
    }
    
    var screenWidth:CGFloat {
        get {
            self.view.screenWidth//DataManager.sharedInstance.getScreenWidth()//return UIScreen.main.bounds.height
        }
        set(newValue) {
            self.view.screenWidth = newValue
        }
    }
    
    var screenHeight:CGFloat {
        get {
            self.view.screenHeight
        }
        set(newValue) {
            self.view.screenHeight = newValue
        }
    }
    
    func openContactPicker(delegate:CNContactPickerDelegate?){
        let contactPicker = CNContactPickerViewController.init()//()
        contactPicker.delegate = delegate
//        contactPicker.displayedPropertyKeys
        self.presentVC(contactPicker)
    }
    
    func openLocationPicker(completation:@escaping ((LocationItem) -> Void)){
        let locationPicker = LocationPicker()
        locationPicker.pickCompletion = { (pickedLocationItem) in
            // Do something with the location the user picked.
            completation(pickedLocationItem)
        }
        locationPicker.addBarButtons()
        // Call this method to add a done and a cancel button to navigation bar.

        let navigationController = UINavigationController(rootViewController: locationPicker)
        self.presentVC(navigationController)
    }
    
    func openAudioRecorder(delegate:AudioRecorderViewControllerDelegate){
        let controller = AudioRecorderViewController()
        controller.audioRecorderDelegate = delegate
//        let navigationController = UINavigationController(rootViewController: controller)
        let vcBs: MDCBottomSheetController = MDCBottomSheetController.init(contentViewController: controller)
        self.presentVC(vcBs)
    }
    
    func openDocPicker(dalegate:UIDocumentPickerDelegate?,caseType:DocPickerCase = .Docs){
        var docPicker =  UIDocumentPickerViewController.init(documentTypes: [kUTTypePDF as String,kUTTypeSpreadsheet as String], in: .import)//(documentTypes: [kUTTypePDF], in: .import)
        if caseType == .Contact {
            docPicker =  UIDocumentPickerViewController.init(documentTypes: [kUTTypeContact as String], in: .import)//(documentTypes: [kUTTypePDF], in: .import)
        }
        docPicker.delegate = dalegate
        if #available(iOS 11, *) {
            docPicker.allowsMultipleSelection = false
        }
        docPicker.modalPresentationStyle = .fullScreen
        self.presentVC(docPicker)
    }
    
    func getImagePicker(_ count :Int = 1,isMultiSelectin:Bool = false,isAlsoVideo :Bool = false,isAlsoVideoAndPicture :Bool = false,callBack: @escaping ([YPMediaItem]?,URL?) -> Void){
        var imagePicker :YPImagePicker?
        //        if(imagePicker == nil){
        var config = YPImagePickerConfiguration()
        config.isScrollToChangeModesEnabled = true
        //            config.onlySquareImagesFromCamera = false
        //            config.usesFrontCamera = false
        config.showsPhotoFilters = true
        config.showsVideoTrimmer = true
        config.maxCameraZoomFactor = 1
        config.shouldSaveNewPicturesToAlbum = true
        config.albumName = "Coleaques"
//        config.pre
        config.showsCrop = .none
        if isAlsoVideoAndPicture {
            config.screens = [.library, .video, .photo]//.photo
            config.video.compression = AVAssetExportPresetHighestQuality
            config.video.fileType = .mp4
            config.video.recordingTimeLimit = 61.0
            config.video.libraryTimeLimit = 61.0
            config.video.minimumTimeLimit = 3.0
            config.video.trimmerMaxDuration = 61.0
            config.video.trimmerMinDuration = 3.0
        }else if(isAlsoVideo){
            config.screens = [.library, .video]//.photo
            config.video.compression = AVAssetExportPresetHighestQuality
            config.video.fileType = .mp4
            config.video.recordingTimeLimit = 61.0
            config.video.libraryTimeLimit = 61.0
            config.video.minimumTimeLimit = 3.0
            //            config.video.
            config.video.trimmerMaxDuration = 61.0
            config.video.trimmerMinDuration = 3.0
        }else{
            config.screens = [.library, .photo]
        }
        if(isAlsoVideoAndPicture) {
            config.startOnScreen = YPPickerScreen.photo
        }else if(isAlsoVideo){
            config.startOnScreen = YPPickerScreen.video
        }else{
            config.startOnScreen = YPPickerScreen.photo
        }
        
        
        config.targetImageSize = YPImageSize.original
        config.overlayView = UIView()
        config.hidesStatusBar = false
        config.hidesBottomBar = false
        config.preferredStatusBarStyle = UIStatusBarStyle.default
        config.bottomMenuItemSelectedTextColour = ProjectColor.redColor///TreccoColor.treccoBlue
        config.bottomMenuItemUnSelectedTextColour = .darkGray//TreccoColor.nonSelectColorContentBy
        //            config.filters = [DefaultYPFilters.]
        //MARK: Library
        config.library.options = .none//..nil
        config.library.onlySquare = false
        config.library.isSquareByDefault = false
        config.library.minWidthForItem = nil
        if isAlsoVideoAndPicture {
            config.library.mediaType = YPlibraryMediaType.photoAndVideo
            config.library.defaultMultipleSelection = false
            config.library.maxNumberOfItems = 1
            config.library.minNumberOfItems = 0
        }else if(isAlsoVideo){
            config.library.mediaType = YPlibraryMediaType.video
            config.library.defaultMultipleSelection = false
            config.library.maxNumberOfItems = 1
            config.library.minNumberOfItems = 0
        }else{
            config.library.mediaType = YPlibraryMediaType.photo
            config.library.defaultMultipleSelection = isMultiSelectin
            config.library.maxNumberOfItems = count
            config.library.minNumberOfItems = 0
        }
        config.library.numberOfItemsInRow = 4
        config.library.spacingBetweenItems = 1.0
        //            config.library.skipSelectionsGallery = false
        config.library.preselectedItems = nil
        YPImagePickerConfiguration.shared = config
        if(imagePicker == nil){
            imagePicker = YPImagePicker(configuration: config)
            imagePicker?.didFinishPicking { [unowned imagePicker] items, cancelled in
                if cancelled {
                    callBack(nil,nil)
                    print("Picker was canceled")
                }else{
                    if(items.count > 1){
                        callBack(items,nil)
                    }else if let photo = items.singlePhoto {
                        print(photo.fromCamera) // Image source (camera or library)
                        print(photo.image) // Final image selected by the user
                        print(photo.originalImage) // original image selected by the user, unfiltered
                        print(photo.modifiedImage as Any) // Transformed image, can be nil
                        print(photo.exifMeta as Any) // Print exif meta data of original image.
                        let imageUrl = photo.image.fixedOrientation()?.writeImageToTemporaryDirectory(resourceName: "image_\(ProcessInfo.processInfo.globallyUniqueString)", fileExtension: "png")
                        callBack(items,imageUrl)
                    }else if let video = items.singleVideo{
                        print(video.fromCamera)
                        print(video.thumbnail)
                        print(video.url)
                        let imageUrl = items.singleVideo?.thumbnail.fixedOrientation()?.writeImageToTemporaryDirectory(resourceName: "image_\(ProcessInfo.processInfo.globallyUniqueString)", fileExtension: "png")
                        callBack(items,imageUrl)
                    }
                }
                imagePicker?.dismiss(animated: true, completion: nil)
            }
        }
        self.present(imagePicker!, animated: true, completion: nil)
    }
    
    
    
    func presentToast(_ smartToastViewController: LoafViewController) {
        smartToastViewController.transDelegate = Manager(loaf: smartToastViewController.loaf, size: smartToastViewController.preferredContentSize)
        smartToastViewController.transitioningDelegate = smartToastViewController.transDelegate
        smartToastViewController.modalPresentationStyle = .custom
        smartToastViewController.view.clipsToBounds = true
        smartToastViewController.view.layer.cornerRadius = 6
        present(smartToastViewController, animated: true)
    }
}

enum DocPickerCase {
    case Docs
    case Contact
}




extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
//        var hexFormatted: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
//
//        if hexFormatted.hasPrefix("#") {
//            hexFormatted = String(hexFormatted.dropFirst())
//        }
//        assert(hexFormatted.count == 6, "Invalid hex code used.")
//        var rgbValue: UInt64 = 0
//        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
//
//        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//                  alpha: alpha)
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
