//
//  TabBarController.swift
//  FavoritePlace
//
//  Created by 김현석 on 2023/03/08.
//

import UIKit
import CoreLocation

class TabBarController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        //        self.tabBar.barTintColor = UIColor(rgb: 0xCCD5AE)
        self.tabBar.tintColor = .systemBlue
        self.tabBar.backgroundColor = .clear
        self.tabBar.isTranslucent = false
        

        let firstVC = UINavigationController(rootViewController: NaverMapViewController())
        
        firstVC.view.backgroundColor = .white
        firstVC.tabBarItem.title = "지도"
        
        firstVC.tabBarItem.image = UIImage(systemName: "map")
        
        
        let secondVC =  UINavigationController(rootViewController: PlaceListViewController())
        secondVC.view.backgroundColor = .white
        secondVC.tabBarItem.title = "맛집노트"
        secondVC.tabBarItem.image = UIImage(systemName: "book.closed")
        
        viewControllers = [firstVC, secondVC]
        
    }
    
}
