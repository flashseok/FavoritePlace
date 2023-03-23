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

        return naverMapView
    }()
    
    let popUpView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.isHidden = true
        
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "YJ")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.isHidden = true
                
        return imageView
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("돌아가기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.isHidden = true
        
        return button
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.isHidden = true
        
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cancelButton, plusButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.isHidden = true
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubViewList()
        setUIConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showPopUpView() {
        self.popUpView.isHidden = true
    }
    
    func addSubViewList() {
        [naverMapView,popUpView,imageView,buttonStackView].forEach {
            self.addSubview($0)
        }
    }
    
    
    func setUIConstraints() {
        setNaverMapViewConstraints()
        setPopUpViewConstraints()
        setImageViewConstraints()
        setButtonStackViewConstraints()
    }
    
    func setNaverMapViewConstraints() {
        naverMapView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.top.equalToSuperview()
        }
    }
    
    
    func setPopUpViewConstraints() {
        popUpView.snp.makeConstraints {
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(50)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-50)
            $0.height.equalTo(UIScreen.main.bounds.height / 2.5)
            $0.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
        }
    }
    
    func setImageViewConstraints() {
        imageView.snp.makeConstraints {
            $0.leading.equalTo(self.popUpView.snp.leading).offset(4)
            $0.trailing.equalTo(self.popUpView.snp.trailing).offset(-4)
            $0.top.equalTo(self.popUpView.snp.top).offset(4)
            $0.bottom.equalTo(self.popUpView.snp.bottom).offset(-30)
        }
    }
    
    func setButtonStackViewConstraints() {
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(2)
            $0.leading.equalTo(self.popUpView.snp.leading).offset(4)
            $0.trailing.equalTo(self.popUpView.snp.trailing).offset(4)
            $0.bottom.equalTo(self.popUpView.snp.bottom).offset(4)
        }
    }
    

    
    
    
    
}




