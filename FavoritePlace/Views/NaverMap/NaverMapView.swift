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
        
    var lat: Double?
    var lng: Double?
    
    let naverMapView: NMFNaverMapView = {
       let naverMapView = NMFNaverMapView()
        naverMapView.showLocationButton = true
        naverMapView.mapView.isIndoorMapEnabled = true
        naverMapView.mapView.isNightModeEnabled = true
        naverMapView.mapView.isRotateGestureEnabled = false
        naverMapView.mapView.isExclusiveTouch = true
        naverMapView.mapView.positionMode = .normal



//        탭바에서 위도: 37.49966512875614
//        탭바에서 경도: 126.73591032365364

        return naverMapView
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
        [naverMapView].forEach {
            self.addSubview($0)
        }
    }
    
    
    func setUIConstraints() {
        naverMapView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.top.equalToSuperview()
        }
        

    }
    
    
}




