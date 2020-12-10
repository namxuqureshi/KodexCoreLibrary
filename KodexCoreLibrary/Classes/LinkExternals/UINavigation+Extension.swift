//
//  UINavigation+Extension.swift
//  MyTouchpoints
//
//  Created by J Aiden on 03/05/2018.
//  Copyright © 2018 Coding Pixel. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    ///Get previous view controller of the navigation stack
    func previousViewController() -> UIViewController?{
        
        let lenght = self.viewControllers.count
        
        let previousViewController: UIViewController? = lenght >= 2 ? self.viewControllers[lenght-2] : nil
        
        return previousViewController
    }
    
}


let kItemHome = "itemHomeList"
extension Notification.Name {
    static let tabViewWillAppear = Notification.Name("tabViewWillAppear")
    static let tabViewWillDisappear = Notification.Name("tabViewWillDisappear")
    
    static let sideMenuOption = Notification.Name("sideMenuOption")
    
    static let makeVip = Notification.Name("makeVip")
    static let notificationCountCheck = Notification.Name("notificationCountCheck")
    static let homeFeedRefresh = Notification.Name("homeFeedRefresh")
    static let chatFeedRefresh = Notification.Name("chatFeedRefresh")
    static let recommendationFeedRefresh = Notification.Name("recommendationFeedRefresh")
    static let chatCountCheck = Notification.Name("chatCountCheck")
    static let successPopUp = Notification.Name("successPopUp")
    static let updateHomeVcItem = Notification.Name("updateHomeVcItem")
    static let presentation_accept = Notification.Name("presentation_accept")
    static let openAnnotationVC = Notification.Name("openAnnotationVC")
    static let openDistributionSignatureVC = Notification.Name("openDistributionSignatureVC")
    static let openOperationVC = Notification.Name("openOperationVC")
    static let openAdvanceVC = Notification.Name("openAdvanceVC")
    static let openQuickRefVC = Notification.Name("openQuickRefVC")
    static let openHomeEye = Notification.Name("openEyeObserver")
    static let refreshDashBoard = Notification.Name("refreshDashBoard")
    static let loadDocumetFromExtention = Notification.Name("loadDocumetFromExtention")
    static let emailSendingProgress = Notification.Name("EmailSendingProgress")
    static let uploadLargeFile = Notification.Name("uploadLargeFile")
    static let fileShared = Notification.Name("fileShared")
    static let hideLoading = Notification.Name("hideLoading")
    static let highlightPDF = Notification.Name("highlightPDF")
    static let appMovedToBackground = Notification.Name("appMovedToBackground")
    static let pdfViewScreenShootsRemove = Notification.Name("PDFViewScreenShootsRemove")
    static let updateSettingsForChange = Notification.Name("UpdateSettingsForChange")
    static let takeUserToBackFromDocReview = Notification.Name("TakeUserToBackFromDocReview")
    static let showAppleAnnTimeAndDate = Notification.Name("showAppleAnnTimeAndDate")
    static let hostDisconnectedMessage = Notification.Name("hostDisconnectedMessage")
    static let docUpload = Notification.Name("DocUpload")
    static let openSelectedBinder = Notification.Name("openSelectedBinder")
    static let openSelectedBinderInDocumentView = Notification.Name("openSelectedBinderInDocumentView")
    static let downLoadMyLitCopy = Notification.Name("downLoadMyLitCopy")
    static let downLoadMyLitCopyFromPinCode = Notification.Name("downLoadMyLitCopyFromPinCode")
    static let updateTheSelectedBinderOnBook = Notification.Name("updateTheSelectedBinderOnBook")
    static let showUploadedFilesCount = Notification.Name("showUploadedFilesCount")
    static let loginSuccessDropBox = Notification.Name("LoginSuccessDropBox")
    static let cancelManuallyDropBox = Notification.Name("CancelManuallyDropBox")
    static let downloadLargePDF = Notification.Name("downloadLargePDF")
    static let openFromExtenstion = Notification.Name("openFromExtenstion")
    static let showLoaderOnBlueToothReceiving = Notification.Name("showLoaderOnBlueToothReceiving")
    static let showBinderViewAfterRearrange = Notification.Name("ShowBinderViewAfterRearrange")
    static let showBinderViewAfterRearrangeCaseFile = Notification.Name("showBinderViewAfterRearrangeCaseFile")
    
}


extension UIApplication {
    class var topViewController: UIViewController? { return getTopViewController() }
    
    private class func getTopViewController(base: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController { return getTopViewController(base: nav.visibleViewController) }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController { return getTopViewController(base: selected) }
        }
        if let presented = base?.presentedViewController { return getTopViewController(base: presented) }
        return base
    }
}

extension Hashable {
    func share() {
        let activity = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        UIApplication.topViewController?.present(activity, animated: true, completion: nil)
    }
}


class MessageWithSubject: NSObject, UIActivityItemSource {
    
    let subject:String
    let message:String
    
    init(subject: String, message: String) {
        self.subject = subject
        self.message = message
        
        super.init()
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return subject
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return message
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController,
                                subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return subject
    }
}
