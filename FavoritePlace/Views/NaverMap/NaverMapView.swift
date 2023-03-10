//
//  NaverMapView.swift
//  FavoritePlace
//
//  Created by 김현석 on 2023/03/08.
//

import UIKit
import NMapsMap
import SnapKit
import CoreLocation

class NaverMapView: UIView {
        
    var lat: CLLocationDegrees? = nil
    var lng: CLLocationDegrees? = nil
    
    lazy var naverMapView: NMFNaverMapView = {
       let naverMapView = NMFNaverMapView()
        naverMapView.showLocationButton = true
        naverMapView.mapView.isIndoorMapEnabled = true
        naverMapView.mapView.isNightModeEnabled = true
        naverMapView.mapView.isRotateGestureEnabled = false
        naverMapView.mapView.isExclusiveTouch = true
        naverMapView.mapView.positionMode = .normal
        naverMapView.mapView.latitude = lat ?? 0
        naverMapView.mapView.longitude = lng ?? 0
        
        return naverMapView
    }()
    
    let plustButton: UIButton = {
       let button = UIButton()
        button.setTitle("추가하기", for: .normal)
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViewList()
        setUIConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addSubViewList() {
        [naverMapView,
         plustButton
        ].forEach {
            self.addSubview($0)
        }
    }
    
    
    func setUIConstraints() {
        naverMapView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.top.equalToSuperview()
        }
        
        plustButton.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(-40)
           
        }
    }
    
    
}




