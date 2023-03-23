//
//  SelectedPlaceView.swift
//  FavoritePlace
//
//  Created by 김현석 on 2023/03/20.
//

import UIKit

class SelectedPlaceView: UIView {

    

    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
        addSubViewList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func addSubViewList() {
        [].forEach {
            self.addSubview($0)
        }
    }
    
    
    func setUIConstraints() {
  
    }
    

    
}
