//
//  BaseViewController.swift
//  KodexCoreNetwork
//
//  Created by Jawad on 11/26/20.
//

import UIKit
import GoogleMaps

open class BaseViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey(placesKey)
    }
    open var localTimeZoneIdentifier: String {
        return TimeZone.current.identifier
    }
    
    //MARK: Show Toast
    open func showToast(textMessage : String , toastType : Loaf.State , toastLocation : Loaf.Location) {
        self.showToast(text: textMessage, type: toastType, location: toastLocation)
    }
    
    
    //MARK: Set Loader Default Color
    open func setLoaderColor(color : UIColor) -> UIColor {
        return color
    }
   
    
    //MARK: Show Loading
    public func showLoading(_ isNeedBlue:Bool = false) {
        DispatchQueue.main.async {
            let blurEffect = UIBlurEffect(style: .prominent)
            let blurView = UIVisualEffectView.init(frame: self.view.frame)
            blurView.tag = 1221
            blurView.effect = blurEffect
            blurView.alpha = CGFloat(0.89)
            if(isNeedBlue){
                self.view.addSubview(blurView)
            }
            self.view.squareLoading.color = ProjectColor.buttonColor
            self.view.squareLoading.backgroundColor = ProjectColor.black.withAlphaComponent(0.2)
            self.view.squareLoading.start(0.0)
        }
    }
    
    public func hideLoading() {
        DispatchQueue.main.async {
            for (_,items) in self.view.subviews.enumerated(){
                if(items.tag == 1221){
                    items.removeFromSuperview()
                    break
                }
            }
            self.view.squareLoading.stop(0.0)
        }
    }
    
    
    @IBAction public func goBack(_ sender : UIButton){
        if self.navigationController != nil{
            self.navigationController?.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }

    //MARK: Get VC From Storyborad
   public func getVC(storyboard : String, vcIdentifier : String) -> UIViewController {
        //String = kStoryBoardMain
        return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: vcIdentifier)
    }
    
    //MARK: Delay
    open func delay(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    
    //MARK: Pop to SpeccifiVC
    open func gotoRootVC(vc : UIViewController){
        if self.navigationController != nil{
            self.navigationController?.popToViewController(vc, animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
