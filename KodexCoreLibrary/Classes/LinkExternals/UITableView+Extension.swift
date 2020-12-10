//
//  UITableView+Extension.swift
//  Trecco
//
//  Created by Jaisee on 11/14/19.
//  Copyright © 2019 
//

import Foundation
import UIKit
import MapKit
extension UITableView{
    func setEmptyMessage(text : String = "No data available") {
        let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        noDataLabel.text          = text
        noDataLabel.font = UIFont(name: "Avenir-Heavy", size: 16.0)!
        noDataLabel.textColor     = UIColor.black.withAlphaComponent(0.7)
        noDataLabel.textAlignment = .center
        self.backgroundView  = noDataLabel
        self.separatorStyle  = .none
    }
    
    
    func removeEmptyMessage()  {
        self.backgroundView = nil
    }
    
    open func registerCell(name : String) {
        self.register(UINib.init(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
}



extension CLLocation {
    
    func fetchCityAndCountry(completion: @escaping (_ city: String, _ country:  String, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality ?? "", $0?.first?.country ?? "", $1) }
    }
    func fetchCityAndCountryState(completion: @escaping (_ city: String, _ country:  String, _ state:  String, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality ?? "", $0?.first?.country ?? "",$0?.first?.administrativeArea ?? "", $1) }
    }
    
    func geocode(completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void)  {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.latitude), completionHandler: completion)
    }
    func getAddressFromLatLon(complition : @escaping(String) -> Void){
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = self.coordinate.latitude
        center.longitude = self.coordinate.longitude
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    
                }else{
                    
                    let pm = placemarks! as [CLPlacemark]
                    if pm.count > 0 {
                        let pm = placemarks![0]
                        
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }else {
                            addressString = addressString + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }else {
                            addressString = addressString + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }else {
                            addressString = addressString + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }else {
                            addressString = addressString + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }else{
                            
                        }
                        complition(addressString)
                        
                    }else{
                        
                        
                        
                    }
                }
        })
    }
}
