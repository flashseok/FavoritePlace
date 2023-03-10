//
//  LocationManager.swift
//  FavoritePlace
//
//  Created by 김현석 on 2023/03/09.
//

import UIKit
import CoreLocation


class LocationManager {
   
    var area: String = ""
    var name: String = ""
    var tuple: (String?, String?)
    
    func findAddr(lat: CLLocationDegrees, long: CLLocationDegrees) -> String? {
        let findLocation = CLLocation(latitude: lat, longitude: long)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        
        var test: String?
        
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            
            if let address: [CLPlacemark] = placemarks {
                
                var myAdd: String = ""
              
                if let area: String = address.last?.locality{
                    myAdd += area
                    self.area = area
                    self.tuple.0 = area
                    print("dddd:\(self.area)")
                }
                
                if let name: String = address.last?.name {
                    myAdd += " "
                    myAdd += name
                    test = name
                    
                    self.name = name
                    self.tuple.1 = name
                }
                
            }
        })
        return test
    }
    
}
