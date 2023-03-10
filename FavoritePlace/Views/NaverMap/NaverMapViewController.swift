//
//  NaverMapViewController.swift
//  FavoritePlace
//
//  Created by 김현석 on 2023/03/08.
//

import UIKit
import NMapsMap
import SnapKit
import CoreLocation

class NaverMapViewController: UIViewController {
    
    let naverMapView = NaverMapView()
    let locationManager = CLLocationManager()
    var lat: CLLocationDegrees?
    var long: CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naverMapView.naverMapView.mapView.touchDelegate = self
        view = naverMapView
        locationSetUp()
        markUpPlace()
    }
    
   
}


extension NaverMapViewController: CLLocationManagerDelegate {
    
    private func locationSetUp() {
        locationManager.delegate = self
        //        locationManager.desiredAccuracy = .
        
        locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                print("위치 서비스 On 상태")
                self.locationManager.startUpdatingLocation()
            } else {
                print("위치 서비스 Off 상태")
            }
        }
    }
    
    
    private func markUpPlace() {
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
        
        marker.mapView = naverMapView.naverMapView.mapView
    }
    
}


extension NaverMapViewController: NMFMapViewTouchDelegate {
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        self.lat = latlng.lat
        self.long = latlng.lng
        print("\(latlng.lat), \(latlng.lng)")
    }

    func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {
        if symbol.caption == "서울특별시청" {
            print("서울시청 탭")
            return true

        } else {
            print("symbol 탭")
            return false
        }
    }
    
    
//    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
//       let alertController = UIAlertController(title: "지도 클릭", message: latlng.positionString(), preferredStyle: .alert)
//       present(alertController, animated: true) {
//           DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 0.5), execute: {
//               alertController.dismiss(animated: true, completion: nil)
//           })
//       }
//   }
}





