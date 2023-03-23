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
    
    let networkManager = NetworkingManager()
    lazy var placeList: PlaceList? = nil
    var markers: [NMFMarker] = []
    let selectedViewController = SelectedPlaceViewController()
        
    let textField: UITextField = {
        let tf = UITextField()
        tf.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 0.6, height: 40)
        tf.backgroundColor = .white
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.spellCheckingType = .no
        tf.keyboardType = .default
        tf.keyboardAppearance = .dark
        tf.layer.borderWidth = 0.3
        tf.layer.cornerRadius = 10 // 모서리 둥글게
        tf.layer.masksToBounds = true // 위 코드랑 세트라 생각하자.
        tf.layer.borderColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0).cgColor
        
        return tf
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        view = naverMapView
        
        naverMapView.naverMapView.mapView.touchDelegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        
        userLocationSetUp()
        textField.delegate = self
        
        setUpNavigationBarItem()
        setEventCall()
        
    }
    

    func setUpNavigationBarItem() {
        self.navigationItem.titleView = textField
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(tappedSearchButton))
    }
    
    func setEventCall() {
        naverMapView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
        naverMapView.plusButton.addTarget(self, action: #selector(tappedPlusButton), for: .touchUpInside)
    }
    
    @objc func tappedCancelButton() {
        naverMapView.popUpView.isHidden = true
        naverMapView.buttonStackView.isHidden = true
        naverMapView.imageView.isHidden = true
        naverMapView.plusButton.isHidden = true
        naverMapView.cancelButton.isHidden = true
    }
    
    @objc func tappedPlusButton() {
        print(#function)
    }
    
    
    @objc func tappedMarker() {
        naverMapView.popUpView.isHidden = false
        naverMapView.buttonStackView.isHidden = false
        naverMapView.imageView.isHidden = false
        naverMapView.cancelButton.isHidden = false
        naverMapView.plusButton.isHidden = false
    }
    
    
    @objc func tappedSearchButton() {
        print(#function)
        
        guard let text = textField.text else { return }
        networkManager.fetchRestaurant(query: text) { result in
            print("여기까지오냐..?")
            dump(result)
            switch result {
            case .success(let placeListData):
                self.placeList = placeListData
                
                DispatchQueue.main.async {
                    self.removeMarker()
                    self.markers = []
                    
                    self.setMarker(place: self.placeList)
                    print("마커 갯수 : \(self.placeList?.documents.count)")
                    self.moveCameraToFirstIndexPlace()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        textField.resignFirstResponder() // TextField 비활성화
        
    }
    
}

// MARK: - CLLocationManagerDelegate
extension NaverMapViewController: CLLocationManagerDelegate {
    
    private func userLocationSetUp() {
        locationManager.delegate = self
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
        print(#function)
        print(error.localizedDescription)
    }
    
    
}

// MARK: - NMFMapViewTouchDelegate
extension NaverMapViewController: NMFMapViewTouchDelegate {
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        // 탭한 곳의 위도,경도
        print("\(latlng.lat), \(latlng.lng)")
        textField.resignFirstResponder() // TextField 비활성화
    }
    
    
    func setMarker(place: PlaceList?) {
        
        self.placeList?.documents.forEach {
            
            guard let x = Double($0.x),
                  let y = Double($0.y) else { return }
            
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: y, lng: x)
            
            
//            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: y, lng: x))
//            cameraUpdate.animation = .fly
//            cameraUpdate.animationDuration = 3
            
            marker.captionText = $0.placeName
            
            marker.isHideCollidedCaptions = true // 마커와 겹치는 다른 마커의 캡션을 자동으로 숨김.
            marker.captionOffset = 2
//            marker.isHideCollidedSymbols = true // 마커가 지도 심볼과 겹치는 경우 심벌을 숨김
//            marker.isHideCollidedMarkers = true // 다른 심볼의 마커와 겹치는 경우 숨김. (z인덱스가 큰마커를 우선) ** marker.zIndex = 100 (인덱스 설정 예시) **
            marker.touchHandler = {(overlay) in
                if let marker1 = overlay as? NMFMarker {
                    print("marker1")
                    print(marker1.captionText)
                    print(marker1.position)
                    
                    
                    self.checkMarkerCaption(marker: marker1)
                }
                return true
            }

            
            markers.append(marker)
            
            markers.forEach {
                $0.mapView = naverMapView.naverMapView.mapView
            }
        }
    }
    
    func checkMarkerCaption(marker: NMFMarker) {
        print(#function)
        print(marker.captionText)
        let text = marker.captionText
        self.placeList?.documents.forEach {
            if $0.placeName == text {
                print("맞다")
                print($0.addressName)
                tappedMarker()
                
            } else {
                print("아니다")
            }
        }
    }
    
    
    func removeMarker() { markers.forEach { $0.mapView = nil } }

    func moveCameraToFirstIndexPlace() {
        
        guard let x = self.placeList?.documents[0].x,
              let y = self.placeList?.documents[0].y else { return }
        
        guard let lng = Double(x),
              let lat = Double(y) else { return }
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
        cameraUpdate.animation = .easeIn
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 3
        self.naverMapView.naverMapView.mapView.moveCamera(cameraUpdate)
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


// MARK: - UITextFieldDelegate
extension NaverMapViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // TextField 비활성화
        tappedSearchButton()
    
        return true
    }
    
    
    
}


