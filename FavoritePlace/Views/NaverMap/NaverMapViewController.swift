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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        view = naverMapView
        
   
        naverMapView.naverMapView.mapView.touchDelegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        
        userLocationSetUp()

        markUpPlace()
    }
}


extension NaverMapViewController: CLLocationManagerDelegate {
    
    private func userLocationSetUp() {
        locationManager.delegate = self
        //        locationManager.desiredAccuracy = .
        
        locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                print("위치 서비스 On 상태")
                self.locationManager.startUpdatingLocation()
                print(self.locationManager.location!.coordinate)
                self.getCurrentUserLocation()

                
            } else {
                print("위치 서비스 Off 상태")
            }
        }
    }
    
    func getCurrentUserLocation() {
        DispatchQueue.main.async {
//            self.locationManager.startUpdatingLocation()
//            print(self.locationManager.location!.coordinate)
            
            // 뷰 로드시 현재 위치로 이동
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: self.locationManager.location?.coordinate.latitude ?? 0, lng: self.locationManager.location?.coordinate.longitude ?? 0))
            cameraUpdate.animation = .easeIn
            self.naverMapView.naverMapView.mapView.moveCamera(cameraUpdate)
        }
    
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("didUpdateLocations")
//        if let location = locations.first {
//            print("위도: \(location.coordinate.latitude)")
//            print("경도: \(location.coordinate.longitude)")
//        }
    }
    
    
    
        // 위도 경도 받아오기 에러
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
        }
    
    
    private func markUpPlace() {
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
        
        marker.mapView = naverMapView.naverMapView.mapView
    }
    
}


extension NaverMapViewController: NMFMapViewTouchDelegate {
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        //        self.lat = latlng.lat
        //        self.lng = latlng.lng
        
        // 탭한 곳의 위도,경도
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
    
}





